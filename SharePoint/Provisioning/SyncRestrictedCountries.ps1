Param(
    [string]$SourceWebUrl = $(throw "Source web url not provided"),
    [string]$SourceCountryListName = $(throw "Restricted countries list name not provided"),
    [string]$TargetWebUrl = $(throw "Target web url not provided")
)

function Get-SourceRestrictedCountries
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$ListName
    )

    $list = $Web.Lists.TryGetList($ListName);
    if ($list -eq $null)
    {
        Write-Host "Cannot find list $ListName..." -ForegroundColor Red
        return $null;
    }

    foreach ($item in $list.Items)
    {
        Write-Output $item["Title"];
    }
}

function Get-TargetRestrictedCountries
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$ListName
    )

    $list = $Web.Lists.TryGetList($ListName);
    if ($list -eq $null)
    {
        Write-Host "Cannot find target list $ListName..." -ForegroundColor Red
        return $null;
    }

    $query = New-Object Microsoft.SharePoint.SPQuery;
    $query.Query = "<Where>
                        <Eq>
                            <FieldRef Name='TAR_TravelRestrictions' />
                            <Value Type='Boolean'>1</Value>
                        </Eq>
                    </Where>";

    $items = $list.GetItems($query);

    foreach ($restrictedCountry in $items)
    {
        Write-Output $restrictedCountry["Title"];
    }
}

function Set-CountriesTravelRestrictions
{
    [CmdletBinding()]
    Param(
       [Microsoft.SharePoint.SPWeb]$Web,
       [string]$ListName,
       [string[]]$Countries,
       [bool]$TravelRestrictions 
    )

    $countriesList = $Web.Lists.TryGetList($ListName);
    if ($countriesList -eq $null)
    {
        Write-Host "Cannot find list $ListName..." -ForegroundColor Red
        return;
    }

    $travelRestrictionsFieldName = "Travel Restrictions Apply";

    foreach ($country in $Countries)
    {
        $query = New-Object Microsoft.SharePoint.SPQuery;
        $query.RowLimit = 1;
        $query.Query = "<Where>
                            <Eq>
                                <FieldRef Name='Title' />
                                <Value Type='Text'>$country</Value>
                            </Eq>
                        </Where>";

        $listItems = $countriesList.GetItems($query);

        if ($listItems.Count -ge 1)
        {
            $countryItem = $listItems[0];

            if ($countryItem[$travelRestrictionsFieldName] -ne $TravelRestrictions)
            {
                $countryItem[$travelRestrictionsFieldName] = $TravelRestrictions;

                $countryItem.Update();
            }
        }
    }

    $countriesList.Update();
}

function Update-TarCountriesList
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$SourceWeb,
        [string]$SourceListName,
        [Microsoft.SharePoint.SPWeb]$TargetWeb
    )

    $TarCountriesListName = "Countries";

    $sourceRestrictedCountries = Get-SourceRestrictedCountries -Web $SourceWeb -ListName $SourceListName;
    $targetRestrictedCountries = Get-TargetRestrictedCountries -Web $TargetWeb -ListName $TarCountriesListName;

    $newRestrictedCountries = $sourceRestrictedCountries | Where { $targetRestrictedCountries -notcontains $_ };
    $removedRestrictedCountries = $targetRestrictedCountries | Where { $sourceRestrictedCountries -notcontains $_ };

    Set-CountriesTravelRestrictions -Web $TargetWeb -ListName $TarCountriesListName -Countries $newRestrictedCountries -TravelRestrictions $true;
    Set-CountriesTravelRestrictions -Web $TargetWeb -ListName $TarCountriesListName -Countries $removedRestrictedCountries -TravelRestrictions $false;
} 

Add-PSSnapin Microsoft.SharePoint.Powershell;

$sourceWeb = Get-SPWeb $SourceWebUrl
$targetWeb = Get-SPWeb $TargetWebUrl

Update-TarCountriesList -SourceWeb $sourceWeb -SourceListName $SourceCountryListName -TargetWeb $targetWeb

