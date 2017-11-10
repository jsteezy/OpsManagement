Param(
    [string]$SourceWebUrl = $(throw "Source web url not provided"),
    [string]$SourceGroupName = $(throw "Site group not provided"),
    [string]$TargetWebUrl = $(throw "Target web url not provided"),
    [string]$TargetGroupName = $(throw "Target site group not provided")
)

function CreateEntryInUserInformationList
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$UserLoginName
    )

    $user = $Web.EnsureUser($UserLoginName);
    if ($user -eq $null)
    {
        Write-Host "Creating entry for user $UserLoginName failed..." -BackgroundColor Red
        return $null;
    }

    Write-Output $user;
}

function MigrateUsers
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$SourceWeb,
        [Microsoft.SharePoint.SPWeb]$TargetWeb,
        [string]$SourceGroupName,
        [string]$TargetGroupName
    )

    $sourceGroup = $SourceWeb.Groups["$SourceGroupName"];
    if ($sourceGroup -eq $null)
    {
        Write-Host "Group $SourceGroupName not found..." -ForegroundColor Red
        return;
    }

    $targetGroup = $TargetWeb.Groups["$TargetGroupName"];
    if ($targetGroup -eq $null)
    {
        Write-Host "Group $TargetGroupName not found..." -ForegroundColor Red
        return; 
    }

    foreach ($sourceUser in $sourceGroup.Users)
    {
        $targetUser = CreateEntryInUserInformationList -Web $TargetWeb -UserLoginName $sourceUser.UserLogin

        Write-Host "Adding user $targetUser..." -ForegroundColor Yellow

        $targetGroup.AddUser($targetUser);

        Write-Host "User added." -ForegroundColor Green
    }
}

$sourceWeb = Get-SPWeb $SourceWebUrl
$targetWeb = Get-SPWeb $TargetWebUrl

MigrateUsers -SourceWeb $sourceWeb -TargetWeb $targetWeb -SourceGroupName $SourceGroupName -TargetGroupName $TargetGroupName