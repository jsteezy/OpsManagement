Param(
    [string]$AmsWebUrl = $(throw "AMS Web url not provided."),
    [string]$TarWebUrl = $(throw "TAR Web url not provided.")
)

. "$($PSScriptRoot)\SP-HelperFunctions.ps1"

function Get-SPUserLoginName
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$User
    )

    try
    {
        [int]$userid= $user.split(";")[0]
        $users = $web.SiteUsers
        $userLogin = $users.GetById($userid)
        return $userLogin.LoginName.ToString();
    }
    catch
    {
        return "";
    }
}

function Export-AccountCodes
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web
    )

    $fromList = $Web.Lists.TryGetList("TAR Account Codes");
    if ($fromList -eq $null)
    {
        Log -Msg "Cannot find list TAR Account Codes from url: $($Web.Url)" -Level Error
        return;
    }

    $outputFile = "$global:MigrationFolder\AccountCodes.csv";

    Write-Output "Title,Code" | Out-File $outputFile

    $accountCodesField = $fromList.Fields["Account Codes"];

    foreach ($accountCode in $accountCodesField.Choices)
    {
        $data = @();

        $indexOfFirstSpace = $accountCode.IndexOf(' ')

        if ($indexOfFirstSpace -gt -1) 
        {
            $code = $accountCode.Substring(0, $indexOfFirstSpace);
            $title = $accountCode.Substring($indexOfFirstSpace + 1, $accountCode.Length - $indexOfFirstSpace - 1);
        }
        else
        {
            $code = $accountCode;
            $title = "No title";
        }

        $data += $title;
        $data += $code;

        Write-Output ($data -join ',') | Out-File -Append $outputFile
    }
}

function Export-Regions
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web
    )

    $listName = "Programming Regions";

    $fromList = $Web.Lists.TryGetList($listName);
    if ($fromList -eq $null)
    {
        Log -Msg "Cannot find list All Countries from url $($Web.Url)" -Level Error
        return;
    }

    $outputFile = "$global:MigrationFolder\Regions.csv";

    Write-Output "Title" | Out-File $outputFile;

    foreach ($item in $fromList.Items)
    {
        Write-Output $item["Programming region"] | Out-File -Append $outputFile
    }
}

function Export-Currencies
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web
    )

    $listName = "Award Currencies";

    $fromList = $Web.Lists.TryGetList($listName);
    if ($fromList -eq $null)
    {
        Log -Msg "Cannot find list All Countries from url $($Web.Url)" -Level Error
        return;
    }

    $outputFile = "$global:MigrationFolder\Currencies.csv";

    Write-Output "Title,Description" | Out-File $outputFile;

    foreach ($item in $fromList.Items)
    {
        $data = @();

        $data += $item["ISO code"];
        $data += $item["Currency name"]

        Write-Output ($data -join ',') | Out-File -Append $outputFile
    }
}

function Export-OrgUnits
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web
    )

    $listName = "Org units";

    $fromList = $Web.Lists.TryGetList($listName);
    if ($fromList -eq $null)
    {
        Log -Msg "Cannot find list All Countries from url $($Web.Url)" -Level Error
        return;
    }

    $outputFile = "$global:MigrationFolder\OrgUnits.csv";

    $regionsOutputFile = "$global:MigrationFolder\OrgUnitsRegions.csv";

    $countriesRegionsOutputFile = "$global:MigrationFolder\CountriesRegions.csv";

    $countriesDirectorsOutputFile = "$global:MigrationFolder\CountryDirectors.csv";

    Write-Output "Name,Code,Reporting,Managed,Countries,Director,Type" | Out-File $outputFile;

    Write-Output "Region,Director" | Out-File $regionsOutputFile;

    Write-Output "Country,Region" | Out-File $countriesRegionsOutputFile;

    Write-Output "Country,Director" | Out-File $countriesDirectorsOutputFile;

    foreach ($item in $fromList.Items)
    {
         $data = @();

         $data += $item["OrgUnit name"];
         $data += $item["OrgUnit code"];

         #region Reporting Office field

         $reportingField = $item["Reporting Office"];

         if ($reportingField)
         {
            $reportingFieldValue = New-Object Microsoft.SharePoint.SPFieldLookupValue($reportingField.ToString());

            $data += """$($reportingFieldValue.LookupValue)""";
         }
         else 
         {
            $data += "";
         }

         #endregion

         #region Managed By field
         
         $managedByField = $item["Managed by"];

         if ($managedByField)
         {
            $managedByFieldValue = New-Object Microsoft.SharePoint.SPFieldLookupValue($managedByField.ToString());

            $data += """$($managedByFieldValue.LookupValue)""";
         }
         else 
         {
            $data += "";
         }

         #endregion

         #region Countries field

         $countriesLookupCollection = New-Object Microsoft.SharePoint.SPFieldLookupValueCollection($item["Default countries of implementation"].ToString());

         $countriesData = @();
         foreach ($lookupCountry in $countriesLookupCollection)
         {
            $countriesData += """$($lookupCountry.LookupValue)""";
         }

         $data += ($countriesData -join ';');

         #endregion

         $data += """$(Get-SPUserLoginName -Web $Web -User ($item['Director']))""";

         $data += $item["Type"];

         Write-Output ($data -join ',') | Out-File -Append $outputFile;

         #region OrgUnits Regions

         $regionsData = @();

         $regionsData += $item["Programming region"];
         $regionsData += $(Get-SPUserLoginName -Web $Web -User ($item["RD Approver"]));

         Write-Output ($regionsData -join ',') | Out-File -Append $regionsOutputFile;

         #endregion

         #region Country Directors

         $countryDirectorsData = @();

         $countriesLookupCollection = New-Object Microsoft.SharePoint.SPFieldLookupValueCollection($item["Default countries of implementation"].ToString());
         foreach ($countryLookup in $countriesLookupCollection)
         {
            $countryDirectorsData += """$($countryLookup.LookupValue)""" + "," + $(Get-SPUserLoginName -Web $Web -User ($item["CD Approver"])) | Out-File -Append $countriesDirectorsOutputFile;
         }

         #endregion

         #region Add to CountriesRegions.csv file

         $region = $item["Programming region"];
         
         $lookupCollection = New-Object Microsoft.SharePoint.SPFieldLookupValueCollection($item["Default countries of implementation"].ToString());
         foreach ($countryLookup in $lookupCollection)
         {
            Write-Output ("""$($countryLookup.LookupValue)""" + "," + $region) | Out-File -Append $countriesRegionsOutputFile
         }

         #endregion
    }
}

function Export-All
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$TarWeb,
        [Microsoft.SharePoint.SPWeb]$AmsWeb
    )

    #Export-AccountCodes -Web $TarWeb
    #Export-Regions -Web $AmsWeb
    Export-OrgUnits -Web $AmsWeb
}

Add-PSSnapin Microsoft.SharePoint.Powershell

$amsWeb = Get-SPWeb $AmsWebUrl
$tarWeb = Get-SPWeb $TarWebUrl

$global:MigrationFolder = "$PSScriptRoot\Migration";

Export-All -TarWeb $tarWeb -AmsWeb $amsWeb
