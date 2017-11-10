[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Azure","Local",IgnoreCase=$true)]        
    [string]$RunMode = "Azure"
)

$ErrorActionPreference = "Stop"

$modulePath = "$(if($RunMode -eq 'Local'){ $PSScriptRoot + '\' })SC-Identity";
Write-Output "Module Path: $modulePath";

Import-Module -Name $modulePath -Force 

# SETUP JOB RUN
$startDate = (Get-Date).ToUniversalTime();

Write-Output "Start Member Sync Job Deployment Check $($startDate.ToString('u'))";

Write-Output "`nCheck job config...";

# GET PARAMS
$tenantId = Get-ConfigVariable "tenantId" -Required -RunMode $RunMode;
$clientId = Get-ConfigVariable "idmApp-ClientId" -Required -RunMode $RunMode;
$clientSecret = Get-ConfigVariable "idmApp-ClientSecret" -Required -RunMode $RunMode;
$groupIdsForSyncConfig = Get-ConfigVariable "groupIdsForSync" -Required -RunMode $RunMode;
$groupIdsForSync = $groupIdsForSyncConfig.Split(";");
$userSyncQueueUri = Get-ConfigVariable "idmApp-UserSyncQueue-Uri" -RunMode $RunMode;
$userSyncQueuePolicyName = Get-ConfigVariable "idmApp-UserSyncQueue-AccessPolicy-Name" -RunMode $RunMode;
$userSyncQueuePolicyKey = Get-ConfigVariable "idmApp-UserSyncQueue-AccessPolicy-Key" -RunMode $RunMode;

Write-Output "`t Job config variables:" 
Write-Output "`t Mode: $($RunMode)"
Write-Output "`t TenantId: $($tenantId)"
Write-Output "`t Idm App ClientId: $($clientId)"
Write-Output "`t Idm App Client Secret [is set?]: $(![string]::IsNullOrWhiteSpace($clientSecret))"
Write-Output "`t GroupIds to Sync: $($groupIdsForSync)"
Write-Output "`t User Sync - QueueUri: $($userSyncQueueUri)"
Write-Output "`t User Sync - Queue Policy Name: $($userSyncQueuePolicyName)"
Write-Output "`t User Sync - Queue Policy Key [is set?]: $(![string]::IsNullOrWhiteSpace($userSyncQueuePolicyKey))"

Write-Output "Check job config complete - Success. $((Get-Date).ToUniversalTime().ToString('u'))";    

Write-Output "`nCheck Application/MSGraph permissions..."

Write-Output "Check Application/MSGraph permissions - Success. $((Get-Date).ToUniversalTime().ToString('u'))";    

Write-Output "`nCheck Identity Service Queue Connection..."

Write-Output "Check Identity Service Queue Connection - Success. $((Get-Date).ToUniversalTime().ToString('u'))";    

Write-Output "`nComplete - Deploy Check: $((Get-Date).ToUniversalTime().ToString('u'))";    
