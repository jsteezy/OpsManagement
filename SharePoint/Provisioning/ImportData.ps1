. "$($PSScriptRoot)\Config.ps1"
. "$($PSScriptRoot)\SP-HelperFunctions.ps1"
. "$($PSScriptRoot)\DataModel-Definitions.ps1"

function Get-User
{
    [CmdletBinding()]
    Param(
        [string]$userValue
    )

    if ($userValue)
    {
        $ensuredUser = $Web.EnsureUser($userValue);

        return New-Object Microsoft.SharePoint.SPFieldUserValue($web, $ensuredUser.ID, $ensuredUser.LoginName);
    }

    return $null;
}

function Import-EmailTemplates
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [string]$ImportPath
    )

    $filePath = $ImportPath + "\EmailTemplates.csv";

    $list = $Web.Lists.TryGetList($global:TAREmailTemplatesListTitle)
    if ($list -eq $null)
    {
        Log "Cannot find the list $global:TAREmailTemplatesListTitle" -Level Error
        return
    }

    Import-Csv $filePath -Delimiter "," | ForEach-Object {
            Write-Host $_.EmailSubject
            Write-Host $_.EmailContentPath

            $emailPath = $ImportPath + "\" + $_.EmailContentPath

            $emailContent = [IO.File]::ReadAllText($emailPath)

            $newItem = $list.AddItem();

            $newItem['Title'] = $_.Title
            $newItem['Email Subject'] = $_.EmailSubject
            $newItem['Email Content'] = $emailContent

            $newItem.Update()
        }

    $list.Update()
}

function Import-TarSettings
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [string]$ImportPath
    )

    $filePath = $ImportPath + "\TarSettings.csv";

    $list = $Web.Lists.TryGetList($global:TARSettingsListTitle)
    if ($list -eq $null)
    {
        Log "Cannot find the list $global:TARSettingsListTitle" -Level Error
        return;
    }

    Import-Csv $filePath -Delimiter "," | ForEach-Object {
            Write-Host $_.Title

            $newItem = $list.AddItem();

            $newItem['Title'] = $_.Title
            $newItem['Setting Value'] = $_.Value
            $newItem['Setting used in'] = $_.UsedIn
            $newItem['Setting type'] = $_.Type

            $newItem.Update()
        }

    $list.Update()
}

function Import-AccountCodes
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$ImportPath
    )

    $filePath = $ImportPath + "\AccountCodes.csv";

    $list = $Web.Lists.TryGetList($global:AccountCodesListTitle);
    if ($list -eq $null)
    {
        Log "Cannot find the list $global:AccountCodesListTitle" -Level Error
        return;
    }

    Import-Csv $filePath -Delimiter ',' | ForEach-Object {
        
        $newItem = $list.AddItem();

        $newItem['Title'] = $_.Title;
        $newItem['Account Code'] = $_.Code;

        $newItem.Update();
    }

    $list.Update();
}

function Import-Currencies
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$ImportPath
    )

    $filePath = $ImportPath + "\Currencies.csv";

    $isoFilePath = $ImportPath + "\ISO4217.csv";

    $list = $Web.Lists.TryGetList($global:CurrenciesListTitle);
    if ($list -eq $null)
    {
        Log "Cannot find the list $global:CurrenciesListTitle" -Level Error
        return;
    }

    $isoFile = Import-Csv $isoFilePath;

    Import-Csv $filePath -Delimiter ',' | ForEach-Object {
        
        $newItem = $list.AddItem();

        $newItem['Title'] = $_.Title;
        $newItem['Description'] = $_.Description;

        $currencyAbbreviation = $_.Title;

        $newItem['Number'] = $($isoFile | Where-Object {$_.Title -eq $currencyAbbreviation}).Number;

        $newItem.Update();
    }

    $list.Update();
}

function Import-Regions
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$ImportPath
    )

    $filePath = $ImportPath + "\Regions.csv";

    $orgUnitsRegionsFilePath = $ImportPath + "\OrgUnitsRegions.csv";

    $list = $Web.Lists.TryGetList($global:RegionsListTitle);
    if ($list -eq $null)
    {
        Log "Cannot find the list $global:RegionsListTitle" -Level Error
        return;
    }

    $orgUnitsRegionsFile = Import-Csv $orgUnitsRegionsFilePath;

    Import-Csv $filePath -Delimiter ',' | ForEach-Object {
        
        $newItem = $list.AddItem();

        $newItem['Title'] = $_.Title;

        $regionName = $_.Title;

        $orgUnitsRegions = $orgUnitsRegionsFile | Where-Object {$_.Region -like "*$regionName"}

        $userList = New-Object Microsoft.SharePoint.SPFieldUserValueCollection;

        foreach ($directorUser in $orgUnitsRegions.Director)
        {
            if ($directorUser)
            {
                $directorValue = Get-User $directorUser

                $userList.Add($directorValue);
            }
        }

        if ($userList.Count -gt 0)
        {
            $newItem['Security Director Account'] = $userList[0];
            $newItem['Security Director Name'] = $userList[0].User.DisplayName;
            $newItem['Security Director Email'] = $userList[0].User.Email;
        }

        $newItem.Update();
    }

    $list.Update();
}

function Import-Countries
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$ImportPath
    )

    $filePath = $ImportPath + "\Countries.csv";

    $regionsFilePath = $ImportPath + "\CountriesRegions.csv";

    $list = $Web.Lists.TryGetList($global:CountriesListTitle);
    if ($list -eq $null)
    {
        Log "Cannot find the list $global:CountriesListTitle" -Level Error
        return;
    }

    $regionsList = $Web.Lists.TryGetList($global:RegionsListTitle);
    if ($regionsList -eq $null)
    {
        Log "Cannot find the list $global:RegionsListTitle" -Level Error
        return;
    }

    $regionsFile = Import-Csv $regionsFilePath -Delimiter ',';

    Import-Csv $filePath -Delimiter ',' -Encoding Unicode | ForEach-Object {
    
        $newItem = $list.AddItem();

        $newItem['Title'] = $_.Title;
        $newItem['ISO Code'] = $_.ISOA3;
        $newItem['Travel Restrictions Apply'] = $_.Restricted;

        $countryName = $_.Title;

        $regionFullName = ($regionsFile | Where-Object { $_.Country -eq $countryName }).Region;

        $regionSplits = $regionFullName -split ";#";

        $regionName = $regionSplits[0];
        if ($regionSplits.Count -gt 1)
        {
            $regionName = $regionSplits[1];
        }

        $regions = $regionsList.Items | Where { $_['Title'] -eq $regionName };

        if ($regions.Count -gt 0)
        {
            $region = $regions;
            if($regions.Count -gt 1)
            {
                $region = $regions[0];
            }

            $regionLookup = New-Object Microsoft.SharePoint.SPFieldLookupValue($region.ID, $region.ID.ToString());

            $newItem['Region'] = $regionLookup;
        }
        else 
        {
            Write-Host "Region $regionName not found..." -ForegroundColor Red
        }

        $newItem.Update();
    }

    $list.Update();
}

function Import-CountryDirectors
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$ImportPath
    )

    $filePath = $ImportPath + "\CountryDirectors.csv";

    $list = $Web.Lists.TryGetList($global:CountriesListTitle);
    if ($list -eq $null)
    {
        Log "Cannot find the list $global:CountriesListTitle" -Level Error
        return;
    }

    Import-Csv $filePath -Delimiter ',' -Encoding Unicode | ForEach-Object {
        
        $countryName = $_.Country;

        $countryItems = $list.Items | Where { $_.Title -eq $countryName };

        if ($countryItems.Count -gt 0) 
        {
            $countryItem = $countryItems;
            if ($countryItems.Count -gt 1)
            {
                $countryItem = $countryItems[0];
            }

            $countryItem["Director"] = Get-User -userValue $_.Director;

            $countryItem.Update();
        }

    }
}

function Import-OrgUnitTypes
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$ImportPath
    )

    $filePath = $ImportPath + "\OrgUnitTypes.csv";

    $list = $Web.Lists.TryGetList($global:OrgUnitTypesListTitle);
    if ($list -eq $null)
    {
        Log "Cannot find the list $global:OrgUnitTypesListTitle" -Level Error
        return;
    }

    Import-Csv $filePath -Delimiter ',' | ForEach-Object {

        $newItem = $list.AddItem();

        $newItem['Title'] = $_.Type;
        $newItem['Description'] = $_.Type;

        $newItem.Update();

    }

    $list.Update();
}

function Import-OrgUnits
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$ImportPath
    )

    $filePath = $ImportPath + "\OrgUnits.csv";

    $list = $Web.Lists.TryGetList($global:OrgUnitsListTitle);
    if ($list -eq $null)
    {
        Log "Cannot find the list $global:OrgUnitsListTitle" -Level Error
        return;
    }

    $countriesList = $Web.Lists.TryGetList($global:CountriesListTitle);
    if ($countriesList -eq $null)
    {
        Log "Cannot find the list $global:CountriesListTitle" -Level Error
        return;
    }

    $orgUnitTypesList = $Web.Lists.TryGetList($global:OrgUnitTypesListTitle);
    if ($orgUnitTypesList -eq $null)
    {
        Log "Cannot find the list $global:OrgUnitTypesListTitle" -Level Error
        return;
    }

    Import-Csv $filePath -Delimiter ',' | ForEach-Object {
    
        $newItem = $list.AddItem();

        $newItem['Title'] = $_.Name;
        $newItem['Code'] = $_.Code;
        $newItem['Director'] = Get-User $_.Director

        #region Type field

        $orgUnitTypeName = $_.Type;

        $orgUnitTypeItems = $orgUnitTypesList.Items | Where { $_['Title'] -eq $orgUnitTypeName };

        if ($orgUnitTypeItems.Count -gt 0)
        {
            $orgUnittypeItem = $orgUnitTypeItems;

            if ($orgUnitTypeItems.Count -gt 1)
            {
                $orgUnittypeItem = $orgUnitTypeItems[0];
            }

            $orgUnitTypeLookup = New-Object Microsoft.SharePoint.SPFieldLookupValue($orgUnittypeItem.ID, $orgUnittypeItem.ID.ToString());

            $newItem['Type'] = $orgUnitTypeLookup;
        }

        #endregion

        #region Managed By field

        $managedByCountryName = $_.Managed;

        $managedByItems = $countriesList.Items | Where { $_['Title'] -eq $managedByCountryName };

        if ($managedByItems.Count -gt 0)
        {
            $managedByItem = $managedByItems;

            if ($managedByItems.Count -gt 1)
            {
                $managedByItem = $managedByItems[0];
            }

            $managedByLookup = New-Object Microsoft.SharePoint.SPFieldLookupValue($managedByItem.ID, $managedByItem.ID.ToString());

            $newItem['Managed By Country'] = $managedByLookup;
        }

        #endregion

        #region Countries field

        $countriesLookupCollection = New-Object Microsoft.SharePoint.SPFieldLookupValueCollection;

        $countriesCollection = $_.Countries -split ';';

        foreach ($countryName in $countriesCollection)
        {
            $countryItems = $countriesList.Items | Where { $_['Title'] -eq $countryName };

            if ($countryItems.Count -gt 0)
            {
                $countryItem = $countryItems;

                if ($countryItems.Count -gt 1)
                {
                    $countryItem = $countryItems[0];
                }

                $countryLookup = New-Object Microsoft.SharePoint.SPFieldLookupValue($countryItem.ID, $countryItem.ID.ToString());

                $countriesLookupCollection.Add($countryLookup);
            }
        }

        $newItem['Countries'] = $countriesLookupCollection;
            
        #endregion

        $newItem.Update();
    }

    #add Reporting to Org unit
    Import-Csv $filePath -Delimiter ',' | ForEach-Object {
        
        $query = New-Object Microsoft.SharePoint.SPQuery;
        $query.RowLimit = 1;
        $query.Query = "<Where>
                            <Eq>
                                <FieldRef Name='Title' />
                                <Value Type='Text'>$($_.Reporting)</Value>
                            </Eq>
                        </Where>";

        $reportingItems = $list.GetItems($query);

        $orgUnitQuery = New-Object Microsoft.SharePoint.SPQuery;
        $orgUnitQuery.RowLimit = 1;
        $orgUnitQuery.Query = "<Where>
                            <Eq>
                                <FieldRef Name='Title' />
                                <Value Type='Text'>$($_.Name)</Value>
                            </Eq>
                        </Where>";

        $orgUnitItems = $list.GetItems($orgUnitQuery);

        if ($reportingItems.Count -ge 1 -and $orgUnitItems.Count -ge 1)
        {
            $reportingOrgUnit = $reportingItems[0];

            $orgUnit = $orgUnitItems[0];

            $reportingFieldValue = New-Object Microsoft.SharePoint.SPFieldLookupValue($reportingOrgUnit.ID, $reportingOrgUnit.ID.ToString());

            $orgUnit['Reports To Organization Unit'] = $reportingFieldValue;

            $orgUnit.Update();
        }
        else 
        {
            Write-Host "Cannot find Org Unit $($_.Reporting) ..." -BackgroundColor Red
        }
    }

    $list.Update();
}

function Import-All()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [string]$ImportPath
    )

    Import-EmailTemplates -Web $web -ImportPath $ImportPath
    Import-TarSettings -Web $web -ImportPath $ImportPath
    Import-AccountCodes -Web $web -ImportPath $ImportPath
    Import-Currencies -Web $web -ImportPath $ImportPath
    Import-Regions -Web $Web -ImportPath $ImportPath
    Import-Countries -Web $Web -ImportPath $ImportPath
    Import-CountryDirectors -Web $Web -ImportPath $ImportPath
    Import-OrgUnitTypes -Web $Web -ImportPath $ImportPath
    Import-OrgUnits -Web $Web -ImportPath $ImportPath
}

Add-PSSnapin Microsoft.SharePoint.Powershell

$web = Get-SPWeb $global:spSiteUrl

Import-All -Web $web -ImportPath "$($PSScriptRoot)\Migration"