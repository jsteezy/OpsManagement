Param (
    $SourceWebUrl = $(throw "Source web url not provided"),
    $TargetWebUrl = $(throw "Target web url not provided")
)

Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue

$sourceWeb = Get-SPWeb $SourceWebUrl
$targetWeb = Get-SpWeb $TargetWebUrl

foreach ($sourceGroup in $sourceWeb.Groups)
{
    $targetGroup = $targetWeb.Groups | Where { $_.Name -eq $sourceGroup.Name };
    if ($targetGroup -ne $null)
    {
        foreach ($user in $sourceGroup.Users)
        {
            Write-Host "Migrating user $user..." -ForegroundColor Yellow
            
            $targetGroup.AddUser($user);

            Write-Host "User migrated" -ForegroundColor Green
        }
    }
}

$targetWeb.Update();

