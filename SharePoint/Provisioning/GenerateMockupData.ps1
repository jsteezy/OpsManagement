Param(
    [string]$WebUrl = $(throw "Web URL is missing"),
    [int]$Count = $(throw "Count is missing"),
    [string]$ListName = $(throw "List name is missing")
)

function GenerateTars
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [int]$Count,
    [string]$ListName
    )

    $list = $Web.Lists.TryGetList($listName)
    if ($list -eq $null)
    {
        Write-Host "List not found: $listName"
        return
    }

    $moraru = $Web.EnsureUser("sci\a.moraru")
    $ilies = $Web.EnsureUser("sci\a.moraru")

    for ($i = 0; $i -lt $Count; $i++)
    {
        $item = $list.AddItem();

        Write-Host "Writing item $i"

        $item["Title"] = "Mock-TAR-$i-$i";
        $item["Requester"] = $moraru;
        $item["Traveller"] = $ilies;
        $item["Emergency Contacts"] = "[]";
        $item["Type of travel"] = "Domestic";
        $item["Visa required"] = "NO";
        $item["Visa number"] = "12345";
        $item["Photo ID"] = "YES";
        $item["Medical Emergency Card"] = "card 1";
        $item["Medical Provider Name"] = "Regina Maria";
        $item["Policy Number"] = "123";
        $item["Read PDI procedure"] = "YES";
        $item["USAID Funds"] = "YES";
        $item["Appropriate vaccination received"] = "YES";
        $item["Travel Advances"] = "[]";
        $item["GSS Training"] = "YES";
        $item["GSS Training Date"] = [System.DateTime]::Now.AddMonths(-14);
        $item["Purpose of travel"] = "test";
        $item["Approved by Director"] = "YES";
        $item["Has Appropriate Emergency Contacts"] = "YES";
        $item["Destinations"] = @'
[{"country":{"__metadata":{"id":"Web/Lists(guid'51584cbd-bcd5-47c1-bc5c-8e8ccae2d0be')/Items(1)","uri":"http://sci-tar.evozon.com/_api/Web/Lists(guid'51584cbd-bcd5-47c1-bc5c-8e8ccae2d0be')/Items(1)","etag":"\"2\"","type":"SP.Data.CountriesListItem"},"director":{"__metadata":{"id":"62317e91-967a-479b-ab9f-aa030287eda0","type":"SP.Data.UserInfoItem"},"Id":2,"Title":"Alexandru Moraru"},"title":"Romania","isoCode":"234","travelRestrictions":false,"$$hashKey":"object:559"},"departureDate":"2016-05-19T21:00:00.000Z","returnDate":null,"isOneWay":true,"$$hashKey":"object:583"}]
'@;
        $item["Budget Session"] =@'
{"flightCost":3232,"currencyType":{"__metadata":{"id":"Web/Lists(guid'a8ea5782-2f78-46a0-8618-49098e445c8b')/Items(1)","uri":"http://sci-tar.evozon.com/_api/Web/Lists(guid'a8ea5782-2f78-46a0-8618-49098e445c8b')/Items(1)","etag":"\"1\"","type":"SP.Data.CurrenciesListItem"},"title":"USD","description":"Dolari","currencyNumber":"123","$$hashKey":"object:367"}}
'@;
        $item["Other estimated costs"] = "[]";
        $item["Budget Codes"] = @'
[{"nickname":"","costCentre":"23232","projectCode":"3232323","sourceOfFund":"32323232","deaCode":"323232","percentage":23,"selectedAccountCode":{"__metadata":{"id":"Web/Lists(guid'0aa7ec00-aeb4-4e00-983a-51aba73b96fc')/Items(1)","uri":"http://sci-tar.evozon.com/_api/Web/Lists(guid'0aa7ec00-aeb4-4e00-983a-51aba73b96fc')/Items(1)","etag":"\"1\"","type":"SP.Data.AccountCodesListItem"},"title":"My Account Code","accountCode":1234,"$$hashKey":"object:868"},"$$hashKey":"object:894"}]
'@;
        $item["Additional Information"] = "no info";
        $item["Travel Coordinator"] = $moraru;
        $item["Budget Approver"] = $ilies;
        $item["Information Read"] = "[]";
        $item["Located in London office"] = "NO";

        #randomize approval
        $rand = Get-Random -Minimum 0 -Maximum 5
        if ($rand -eq 0)
        {
            $item["Requires GSS Approval"] = 0;
            $item["Budget Approval Status"] = "Approved";
        }
        elseif ($rand -eq 1)
        {
            $item["Requires GSS Approval"] = 1;
            $item["Budget Approval Status"] = "Approved";
            $item["GSS Approval Status"] = "Approved";
        }
        elseif ($rand -eq 2)
        {
            $item["Requires GSS Approval"] = 0;
            $item["Budget Approval Status"] = "Rejected";
        }
        elseif ($rand -eq 3)
        {
            $item["Requires GSS Approval"] = 1;
            $item["Budget Approval Status"] = "Approved";
            $item["GSS Approval Status"] = "Rejected";
        }

        
        $item["Departure Date"] = [System.DateTime]::Now.AddMonths(-13);
        $item["Created"] = [System.DateTime]::Now.AddMonths(-13);
        $item["Modified"] = [System.DateTime]::Now.AddMonths(-13);

        $item.Update()
    }

    $list.Update()
}

function GenerateEifs
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [int]$Count
    )

    $listName = "EIF Requests";

    $list = $Web.Lists.TryGetList($listName)
    if ($list -eq $null)
    {
        Write-Host "List not found: $listName"
        return
    }

    $moraru = $Web.EnsureUser("evozon\alexandru.moraru")
    $ilies = $Web.EnsureUser("evozon\alexandru.moraru")

    for ($i = 0; $i -lt $Count; $i++)
    {
        $item = $list.AddItem();

        Write-Host "Writing item $i"

        $item["Title"] = "Mock-EIF-$i-$i";
        $item["Requester"] = $moraru;
        $item["Staff responsible for guest traveller"] = $ilies;
        $item["First Name"] = "First Name";
        $item["Last Name"] = "Last Name";
        $item["Contact number"] = "012546325";
        $item["Date of birth"] = [System.DateTime]::Now;
        $item["Passport number"] = "A454521";
        $item["Passport's country of issue"] = "Romania";
        $item["Country of origin"] = "Romania";
        $item["VISA Number(s) for countries you are visiting"] = "145236";
        $item["Destinations"] = @'
[{"country":{"__metadata":{"id":"Web/Lists(guid'51584cbd-bcd5-47c1-bc5c-8e8ccae2d0be')/Items(1)","uri":"http://sci-tar.evozon.com/_api/Web/Lists(guid'51584cbd-bcd5-47c1-bc5c-8e8ccae2d0be')/Items(1)","etag":"\"2\"","type":"SP.Data.CountriesListItem"},"director":{"__metadata":{"id":"62317e91-967a-479b-ab9f-aa030287eda0","type":"SP.Data.UserInfoItem"},"Id":2,"Title":"Alexandru Moraru"},"title":"Romania","isoCode":"234","travelRestrictions":false,"$$hashKey":"object:559"},"departureDate":"2016-05-19T21:00:00.000Z","returnDate":null,"isOneWay":true,"$$hashKey":"object:583"}]
'@;
        $item["Emergency contact name"] = "Em contact name";
        $item["Emergency contact relationship"] = "Em contact rel";
        $item["Emergency contact email"] = "email@email.com";
        $item["Emergency contact home phone"] = "home phone";
        $item["Emergency contact office phone"] = "office phone";
        $item["Emergency contact mobile phone"] = "mobile phone";
        $item["Travel/Route Details"] = "route";
        $item["Medical conditions"] = "med cond";
        $item["Blood type"] = "A+";
        $item["Insurance policy number"] = "policy";
        $item["Insurance company"] = "company";
        $item["Insurance company phone number"] = "comp phone";
        $item["Insurance contact"] = "contact";
        $item["Additional comments"] = "no comm";
        $item["Information Read"] = "{}";
        $item["TAR Id"] = "nothing";
        $item["Departure Date"] = [System.DateTime]::Now.AddMonths(-13);
        $item["Created"] = [System.DateTime]::Now.AddMonths(-13);
        $item["Modified"] = [System.DateTime]::Now.AddMonths(-13);

        $item.Update()
    }

    $list.Update()
}

Add-PSSnapin Microsoft.SharePoint.Powershell

$web = Get-SPWeb $WebUrl

GenerateTars -Web $web -Count $Count -ListName $ListName
GenerateEifs -Web $web -Count $Count 