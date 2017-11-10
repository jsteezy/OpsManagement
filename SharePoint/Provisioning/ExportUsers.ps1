Param(
    [string]$WebUrl = $(throw "Web URL not provided")
)

Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue

$web = Get-SPWeb $WebUrl

$jsonObject = @{};

foreach ($group in $web.Groups)
{
    $jsonObject["$($group.Name)"] = @();

    foreach ($user in $group.Users) 
    {
        $jsonObject["$($group.Name)"] += $user.LoginName;
    }
}

$json = $jsonObject | ConvertTo-JSON 

Write-Output $json | Out-File "$PSScriptRoot\Migration\Users.json"