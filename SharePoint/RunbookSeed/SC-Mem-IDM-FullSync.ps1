
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Azure","Local",IgnoreCase=$true)]        
    [string]$RunMode
)

$modulePath = "$(if($RunMode -eq 'Local'){ $PSScriptRoot + '\' })SC-Identity";
Write-Output "Module Path: $modulePath";
Import-Module -Name $modulePath -Force 

# SETUP JOB RUN
$startDate = (Get-Date).ToUniversalTime();
$correlationId = [guid]::NewGuid();

#Publish-ControlMessage -Type "StartSync" -Body $startDate
# GET PARAMS
$tenantId = Get-ConfigVariable "tenantId" -Required -RunMode $RunMode;
$clientId = Get-ConfigVariable "idmApp-ClientId" -Required -RunMode $RunMode;
$clientSecret = Get-ConfigVariable "idmApp-ClientSecret" -Required  -RunMode $RunMode;
$groupIdsForSyncConfig = Get-ConfigVariable "groupIdsForSync" -Required  -RunMode $RunMode;
$groupIdsForSync = $groupIdsForSyncConfig.Split(";");
#$groupSyncDeltaLink = Get-ConfigVariable "idmApp-GroupSync-DeltaLink";
#$userSyncDeltaLink = Get-ConfigVariable "idmApp-UserSync-DeltaLink";
$userSyncQueueUri = Get-ConfigVariable "idmApp-UserSyncQueue-Uri" -Required -RunMode $RunMode;
$userSyncQueuePolicyName = Get-ConfigVariable "idmApp-UserSyncQueue-AccessPolicy-Name" -Required -RunMode $RunMode;
$userSyncQueuePolicyKey = Get-ConfigVariable "idmApp-UserSyncQueue-AccessPolicy-Key" -Required -RunMode $RunMode;

Write-Output "Start Full Group Sync: $($startDate.ToString('u'))";
Write-Output "`t Mode: $($RunMode)"
Write-Output "`t CorrelationId: $($correlationId)"
Write-Output "`t TenantId: $($tenantId)"
Write-Output "`t IdmAppClientId: $($clientId)"
Write-Output "`t GroupIds to Sync: $($groupIdsForSync)"
Write-Output "`t User Sync - QueueUri: $($userSyncQueueUri)"
Write-Output "`n"

#Write-Output "`t GroupSync Delta Link: $($groupSyncDeltaLink)"
#Write-Output "`t UserSync Delta Link: $($userSyncDeltaLink)"

try {
    # Get MS Graph Access
    $token = Get-GraphAccessToken -tenant $tenantId `
                                -clientId $clientId `
                                -clientSecret $clientSecret

    # Build the Groups delta query OData filter
    $groupsFilter = "";
    foreach($groupId in $groupIdsForSync){
        if($groupsFilter.Length -gt 0) { $groupsFilter += " OR "; }
        $groupsFilter += "id eq '$($groupId)'";
    }

    # Get Group Delta Result
    $groupsResourceUri = "/groups/delta?`$select=id,displayName,members&`$filter=$($groupsFilter)";
    Write-Output "Call MSGraph groups delta resource: $($groupsResourceUri)"
    $groupsDeltaResult = Execute-MSGraph -Tenant $tenantId -AccessToken $token -Resource $groupsResourceUri

    $nextLink = "";
    $deltaLink = "";
    $allGroups = @();

    Write-Output "`nProcess Delta Group Results...";

    while([string]::IsNullOrEmpty($deltaLink))
    {    
        $groups = $groupsDeltaResult.value;        
        $nextLink = $groupsDeltaResult.'@odata.nextLink';
        $deltaLink = $groupsDeltaResult.'@odata.deltaLink'

        Write-Output "`tResult - Groups returned: $($groups.Count),`tNext Link: $(![string]::IsNullOrEmpty($nextLink)), `tDelta Link: $(![string]::IsNullOrEmpty($deltaLink))";        
        $allGroups += $groups;

        if(![string]::IsNullOrEmpty($nextLink)){
            Start-Sleep -Milliseconds 500;
            $groupsDeltaResult = Execute-MSGraph -Tenant $tenantId -AccessToken $token -Link $nextLink
        }
    }

    Write-Output "All groups returned: $($allGroups.Count)"

    $usersToEnsure = @{};
    $usersToRemove = @{};
    $usersToIgnore = @{};
    
    foreach($group in $allGroups){
        Write-Output "Full Sync Group: $($group.displayName)"

        $allGroupMembers = $group.'members@delta';

        foreach($groupUser in $allGroupMembers){  
            $userRecord = Get-UserDetail -Id $groupUser.id -TenantId $tenantId -AccessToken $token

            if(Should-UserBeSynced $userRecord)
            {
                $userRemoved = ($groupUser.'@removed' -ne $null);
            
                if($userRemoved){
                    $usersToRemove.Add($userRecord.id, $userRecord);                    
                } else {
                    $usersToEnsure.Add($userRecord.id, $userRecord);                    
                }
            }
            else{
                $usersToIgnore.Add($userRecord.id, $userRecord);
            }            
        }
    }

    Write-Output "`nEnsure Users:"
    foreach($userToEnsure in $usersToEnsure.GetEnumerator())
    {
        $user = $userToEnsure.Value;  
        #Sync-EnsureUser -UserObject $userToEnsure -SasToken $sasToken
        Write-Output "`tEnsure User: $($user.userPrincipalName)";
    }

    Write-Output "`nRemove Users:"
    foreach($userToRemove in $usersToRemove.GetEnumerator())
    {
        $user = $userToRemove.Value;        
        Write-Output "`tEnsure User Removal: $($user.userPrincipalName)";
    }

    Write-Output "`nIgnore Users:"
    foreach($userToIgnore in $usersToIgnore.GetEnumerator())
    {
        $user = $userToIgnore.Value;        
        Write-Output "`tUser Ignored: $($user.userPrincipalName)";
    }

    Set-ConfigVariable "idmApp-GroupSync-DeltaLink" -Value $deltaLink -RunMode $RunMode;
    Set-ConfigVariable "fullSyncLastRun" -Value $startDate.ToString("u") -RunMode $RunMode;
    
    Write-Output "`nComplete - Full Group Sync: $((Get-Date).ToUniversalTime().ToString('u'))";    
    Write-Output "Users Ensured: $($usersToEnsure.Count)";    
    Write-Output "Users Removed: $($usersToRemove.Count)";    
    Write-Output "Users Ignored: $($usersToIgnore.Count)";

    # Do dummy User Delta Query
}
catch {
    Write-Error "Exception occurred in Full Sync: $($_.Exception.Message)";
}

#$allUsers = Execute-MSGraph -Tenant $tenant -AccessToken $token -Resource "/users"
#$allUsers.value


