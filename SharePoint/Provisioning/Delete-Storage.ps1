. "$($PSScriptRoot)\Config.ps1"
. "$($PSScriptRoot)\SP-HelperFunctions.ps1"
. "$($PSScriptRoot)\DataModel-Definitions.ps1"

function Delete-Storage 
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web
    )

    $listNames = Get-ListNames
    Write-Host $listNames

    Remove-CircularReferences -Web $Web

    Remove-AllLists -Web $Web -ListNames $listNames

    #remove Export document library
    Remove-AllLists -Web $Web -ListNames $global:solutionExportDocLibraryName

    Remove-UserProfileLists -Web $Web

    Remove-ArchiveLists -Web $Web

    Remove-AllContentTypes -Web $Web -GroupName $global:CTGroup

    Remove-AllSiteColumns -Web $Web -GroupName $global:FieldDefGroup
}

function Remove-CircularReferences
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web
    )

    $orgUnitsCT = $Web.ContentTypes[$global:CTDefOrgUnits.Name];

    if ($orgUnitsCT -eq $null) 
    {
        return;
    }

    $countriesField = $Web.Fields[$global:FieldDefCountriesLookupMulti.DisplayName];

    if ($countriesField -eq $null)
    {
        return;
    }
    
    $orgUnits_CountriesLookup = New-Object Microsoft.SharePoint.SPFieldLink($countriesField);

    $orgUnitsCT.FieldLinks.Delete($orgUnits_CountriesLookup.Id);
    $orgUnitsCT.Update();
}

function Remove-UserProfileLists
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web
    )

    $userProfileLists = $Web.Lists | Where {$_.Title -like "User Profile*"}

    Write-Host $userProfileLists

    Remove-AllLists -Web $Web -ListNames $userProfileLists
}

function Remove-ArchiveLists
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web
    )

    $archiveLists = $Web.Lists | Where {$_.Title -like "TAR Requests Archive*"}

    Write-Host $archiveLists

    Remove-AllLists -Web $Web -ListNames $archiveLists
}

Add-PSSnapin Microsoft.SharePoint.Powershell

$web = Get-SPWeb $global:spSiteUrl

Delete-Storage -Web $web

$web.Update();