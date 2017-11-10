Param(
    [string]$WebUrl = $(throw "Web URL is missing"),
    [string]$DocLibraryName = $(throw "Document library name is missing")
)

. "$($PSScriptRoot)\UploadFilesInLibrary.ps1"

function GetListItems
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$ListName
    )

    $list = $Web.Lists.TryGetList($ListName);
    if ($list -eq $null) 
    {
        Write-Host "List $ListName not found";
        return $null;
    }

    return $list.Items;
}

function GetTARRequestArchiveListNames
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web
    )

    $listPropertyTitles = $Web.Lists | Where { $_.Title -like "TAR Requests Archive*" } | Select -Property Title;

    $listNames = New-Object System.Collections.ArrayList

    Write-Output "TAR Requests";

    foreach ($listTitle in $listPropertyTitles) 
    {
        Write-Output $listTitle.Title;
    }
}

function GetColumnNames
{
    Write-Output "Title"
    Write-Output "Requester"
    Write-Output "Traveller"
    Write-Output "Destinations"
    Write-Output "Restricted Countries"
    Write-Output "Country Directors"
    Write-Output "Departure Date"
    Write-Output "Return Date"
    Write-Output "Budget Approver"
    Write-Output "Budget approval status"
    Write-Output "Budget approval timestamp"
    Write-Output "GSS approval status"
    Write-Output "GSS approval timestamp"
    Write-Output "Created"
    Write-Output "Created Date and Time"
    Write-Output "Account Codes"
    Write-Output "Cost Centres"
    Write-Output "Project Codes"
    Write-Output "Source of Funds"
    Write-Output "DEA Codes"
    Write-Output "Percentages"
	Write-Output "Flight costs"
    Write-Output "Currency"
	Write-Output "Board lodging costs"
    Write-Output "Other estimated costs"
    Write-Output "Purpose of travel"
}

function Process-UserField
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        $UserField
    )

    $userObj = New-Object Microsoft.SharePoint.SPFieldUserValue($Web, $UserField);

    Write-Output """$($userObj.LookupValue)""";
}

function Process-DateField
{
    [CmdletBinding()]
    Param(
        $Date
    )

    if ($Date -eq $null)
    {
        return "";
    }

    $newDate = [System.DateTime]::Parse($Date);

    return $newDate.ToString("yyyy-MM-dd");
}

function Process-TARItem
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [Microsoft.SharePoint.SPListItem]$item
    )

    Write-Output $item['Title']
    
    $requester = Process-UserField -Web $Web -UserField $item['Requester']
    Write-Output $requester
    
    $traveller = Process-UserField -Web $Web -UserField $item['Traveller']
    Write-Output $traveller

    #region Destinations, Restricted Countries, Country Directors
    $destinations = ConvertFrom-Json -InputObject $item['Destinations']

    $countries = @();
    $restrictedCountries = @();
    $directors = @();

    foreach ($destination in $destinations) 
    {
        $countries += $destination.country.title;
        
        if ($destination.country.travelRestrictions)
        {
            $restrictedCountries += $destination.country.title;
        }

        $directors += $destination.country.director.Title;
    }

    Write-Output ($countries -join ';');
    Write-Output ($restrictedCountries -join ';');
    Write-Output ($directors -join ';');
    #endregion

    Write-Output $item["Departure Date"].ToString("yyyy-MM-dd");

    $returnDate = Process-DateField -Date $item["Return Date"]
    Write-Output $returnDate

    $budgetApprover = Process-UserField -Web $Web -UserField $item["Budget Approver"]
    Write-Output $budgetApprover

    Write-Output $item["Budget Approval Status"]

    $budgetTimestamp = Process-DateField -Date $item["Budget Approval Timestamp"]
    Write-Output $budgetTimestamp

    Write-Output $item["GSS Approval Status"]

    $gssTimestamp = Process-DateField -Date $item["GSS Approval Timestamp"]
    Write-Output $gssTimestamp

    if ($item["TAR Created"])
    {
        Write-Output $item["TAR Created"].ToString("yyyy-MM-dd");
        Write-Output $item["TAR Created"].ToString("G");
    }
    else
    {
        Write-Output $item["Created"].ToString("yyyy-MM-dd");
        Write-Output $item["Created"].ToString("G");
    }

    #region Budget Codes: Cost Centre, Project Code, Source of fund, DEA Code, Percentage

    $budgetCodes = ConvertFrom-Json -InputObject $item['Budget Codes'];

    $accountCodes = @();
    $costCentres = @();
    $projectCodes = @();
    $sourceOfFunds = @();
    $deaCodes = @();
    $percentages = @();

    foreach ($budgetCode in $budgetCodes)
    {
        $accountCodes += $budgetCode.selectedAccountCode.accountCode;
        $costCentres += $budgetCode.costCentre;
        $projectCodes += $budgetCode.projectCode;
        $sourceOfFunds += $budgetCode.sourceOfFund;
        $deaCodes += $budgetCode.deaCode;
        $percentages += $budgetCode.percentage;
    }

    Write-Output ($accountCodes -join ';');
    Write-Output ($costCentres -join ';');
    Write-Output ($projectCodes -join ';');
    Write-Output ($sourceOfFunds -join ';');
    Write-Output ($deaCodes -join ';');
    Write-Output ($percentages -join ';');

    #endregion

    #region Budget Session

    $budgetSession = ConvertFrom-Json -InputObject $item["Budget Session"];

    $flightCost = $budgetSession.flightCost
    $currency = $budgetSession.currencyType.title

    Write-Output $flightCost
    Write-Output $currency

    #endregion

    #region Costs

    $otherEstimatedCosts = ConvertFrom-Json -InputObject $item['Other estimated costs'];

    $boardLodgingCosts = @();
    $otherCosts = @();

    foreach ($estimatedCost in $otherEstimatedCosts)
    {
        $boardLodgingCosts += $estimatedCost.estimatedBoard;
        $otherCosts += $estimatedCost.otherCosts;
    }

    Write-Output ($boardLodgingCosts -join ';');
    Write-Output ($otherCosts -join ';');

    #endregion

    Write-Output $item["Purpose of travel"];
}

function Create-Excel
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$DocLibraryname
    )

    $exportFileName = "TAR-Export-$([System.DateTime]::Now.ToString('yyyy-MM-dd')).csv";

    Remove-Item "$PSScriptRoot\$exportFileName" -ErrorAction SilentlyContinue

    $columnNames = GetColumnNames;

    #write the separator in the header, otherwise it will not interpret correctly
    Write-Output "sep=," | Out-File "$PSScriptRoot\$exportFileName"

    Write-Output $($columnNames -join ',') | Out-File -Append "$PSScriptRoot\$exportFileName"

    $archiveListNames = GetTARRequestArchiveListNames -Web $Web

    foreach ($archiveList in $archiveListNames)
    {
        $items = GetListItems -Web $Web -ListName $archiveList

        foreach ($tarItem in $items) 
        {
            $result = Process-TARItem -item $tarItem
            Write-Output ($result -join ',') | Out-File -Append "$PSScriptRoot\$exportFileName" 
        }
    }

    UploadFilesInLibrary -WebUrl $Web.Url -FolderPath "$PSScriptRoot\$exportFileName" -DocLibName $DocLibraryname

    Remove-Item "$PSScriptRoot\$exportFileName" -ErrorAction SilentlyContinue
}

Add-PSSnapin Microsoft.SharePoint.Powershell

$web = Get-SPWeb $WebUrl

Create-Excel -Web $web -DocLibraryname $DocLibraryName