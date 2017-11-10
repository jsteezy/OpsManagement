Param(
    [string]$WebUrl = $(throw "Web URL not provided")
)

Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue

$web = Get-SPWeb $WebUrl

$jsonObject = ConvertFrom-Json -InputObject (Get-Content "$PSScriptRoot\Migration\Users.json" -Raw)

$groupProperties = ($jsonObject | Get-Member -MemberType *Property);

foreach ($group in $groupProperties)
{
    Write-Host $group.Name

    $targetGroup = $web.Groups[$group.Name];

    if ($targetGroup -ne $null)
    {
        foreach ($userLoginName in $jsonObject.psobject.Properties["$($group.Name)"].Value)
        {
            $user = $web.EnsureUser($userLoginName);

            if ($user -eq $null)
            {
                Write-Host "User $userLoginName not found..." -ForegroundColor Red
            }
            else 
            {
                $targetGroup.AddUser($user);
            }
        }

        $targetGroup.Update();
    }
}

$web.Update();