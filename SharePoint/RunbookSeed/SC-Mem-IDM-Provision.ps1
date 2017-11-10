Import-Module '.\SC-Identity.psm1'
Import-Module AzureAD
# SCRIPT VARS
$resourceGroupName = "";
$automationAccountName = "";
$identitySyncAppName = "";
$identitySyncAppIdentifier = "";

$ErrorActionPreference = "Stop";

#params (get from provision config)
$deployLocation = "UK South";
$subscriptionId = "";
$topicUri = "";
$topicPolicyName = "";
$topicPolicyKey = "";
$groupIdsToSync = "";

# TODO - GET AND VALIDATE PARAMS FROM FILE

Write-Host "Logging in AzureRm and AzureAD..." -ForegroundColor Cyan;

if(!$creds)
{
    $user = Read-Host -Prompt "User";
    $pwd = Read-Host "Password" -AsSecureString
    $creds = New-Object System.Management.Automation.PSCredential ($user, $pwd);
}

Login-AzureRmAccount -Credential $creds;
Connect-AzureAD -Credential $creds

Write-Host "Selecting subscription '$subscriptionId'";
Select-AzureRmSubscription -SubscriptionID $subscriptionId;

$context = Get-AzureRmContext

# Ensure resource group
Write-Host "`nEnsure Resource Group '$($resourceGroupName)'..." -ForegroundColor Cyan;
# Create or check for existing resource group
$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if(!$resourceGroup)
{
    Write-Host "Resource group '$resourceGroupName' does not exist. To create a new resource group, please enter a location.";
    if(!$deployLocation) {
        $deployLocation = Read-Host "resourceGroupLocation";
    }
    Write-Host "Creating resource group '$resourceGroupName' in location '$deployLocation'";
    New-AzureRmResourceGroup -Name $resourceGroupName -Location $deployLocation
}
else{
    Write-Host "Using existing resource group '$resourceGroupName'";
}
Write-Host "Done." -ForegroundColor Green;

# Ensure automation account
Write-Host "`nEnsure Automation Account '$($automationAccountName)'..." -ForegroundColor Cyan;
$automationAccount = Get-AzureRmAutomationAccount -Name $automationAccountName -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue
if(!$automationAccount)
{
    Write-Host "Creating Automation Account '$($automationAccountName)' in location '$($deployLocation)... " -NoNewline
    New-AzureRmAutomationAccount -ResourceGroupName $resourceGroupName -Name $automationAccountName -Location $deployLocation
    $automationAccount = Get-AzureRmAutomationAccount -Name $automationAccountName -ResourceGroupName $resourceGroupName
    Write-Host "Done." -ForegroundColor Green

    Write-Host "Import SC-Identity module..." -NoNewline
    $module = New-AzureRmAutomationModule -ResourceGroupName $resourceGroupName -Name "SC-Identity" -AutomationAccountName $automationAccountName `
                                          -ContentLink "https://scisistoragetest.blob.core.windows.net/si-module/SC-Identity.zip"
    Write-Host "Done." -ForegroundColor Green
}
else{
    Write-Host "Automation Account '$($automationAccountName)' already exists";
}
Write-Host "Done." -ForegroundColor Green;


Write-Host "`nProvision AzureAD App for Identity Sync Job..." -ForegroundColor Cyan;

$app = Get-AzureRmADApplication -IdentifierUri $identitySyncAppIdentifier

if(!$app){

    $startDate = Get-Date
    $endDate = $startDate.AddYears(2);
    
    $aesManaged = New-Object "System.Security.Cryptography.AesManaged"
    $aesManaged.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $aesManaged.Padding = [System.Security.Cryptography.PaddingMode]::Zeros
    $aesManaged.BlockSize = 128
    $aesManaged.KeySize = 256
    $aesManaged.GenerateKey()

    $psadCredential = New-Object Microsoft.Azure.Commands.Resources.Models.ActiveDirectory.PSADPasswordCredential
    $psadCredential.StartDate = $startDate
    $psadCredential.EndDate = $endDate
    $psadCredential.KeyId = [guid]::NewGuid()
    $psadCredential.Password = [System.Convert]::ToBase64String($aesManaged.Key)
    $appCred = $psadCredential;

    Write-Host "Creating Azure AD Application '$($IdentitySyncAppName)'";
    $app = New-AzureRmADApplication -DisplayName $IdentitySyncAppName -IdentifierUris @($IdentitySyncAppIdentifier) `
                            -PasswordCredentials $psadCredential

    Write-Host "Azure AD Application '$($IdentitySyncAppName)' created.";
    
    Start-Sleep -Seconds 3   

    Write-Host "Ensure App Permissions to MS Graph...";

    $graphAccess = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]@{
                    ResourceAppId="00000003-0000-0000-c000-000000000000"; # MS Graph App
                    ResourceAccess=[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
                        Id = "7ab1d382-f21e-4acd-a863-ba3e13f7da61" ; # Directory.Read.All
                        Type = "Role"},
                        [Microsoft.Open.AzureAD.Model.ResourceAccess]@{
                        Id = "5b567255-7703-4780-807c-7be8301ae99b" ; # Group.Read.All
                        Type = "Role"},
                        [Microsoft.Open.AzureAD.Model.ResourceAccess]@{
                        Id = "df021288-bdef-4463-88db-98f22de89214" ; # user.Read.All
                        Type = "Role"}
    }

    Set-AzureADApplication -ObjectId $app.ObjectId -RequiredResourceAccess $graphAccess     

    Write-Host "Ensure App Permissions to MS Graph - Completed.";

    #Call Graph with client and password
} 
else {
    Write-Host "AzureAD App '$($IdentitySyncAppName)' already exists";
}

Write-Host "Done." -ForegroundColor Green;


Write-Host "`nEnsure Automation Variables..." -ForegroundColor Cyan;
# Get provision config vars
$variables = @();

# Empty Variables
$variables += New-Object PSObject -Property @{ Name = "fullSyncLastRun"; Value = ""; Encrypt = $false }
$variables += New-Object PSObject -Property @{ Name = "idmApp-GroupSync-DeltaLink"; Value = ""; Encrypt = $false }
$variables += New-Object PSObject -Property @{ Name = "idmApp-UserSync-DeltaLink"; Value = ""; Encrypt = $false }

# Config Variables
$variables += New-Object PSObject -Property @{ Name = "tenantId"; Value = $context.Tenant.TenantId; Encrypt = $false }
$variables += New-Object PSObject -Property @{ Name = "idmApp-ClientId"; Value = $app.ApplicationId; Encrypt = $false }
$variables += New-Object PSObject -Property @{ Name = "idmApp-ClientSecret"; Value = $appCred.Password; Encrypt = $true }
$variables += New-Object PSObject -Property @{ Name = "groupIdsForSync"; Value = $groupIdsToSync; Encrypt = $false }
$variables += New-Object PSObject -Property @{ Name = "idmApp-UserSyncQueue-Uri"; Value = $topicUri; Encrypt = $false }
$variables += New-Object PSObject -Property @{ Name = "idmApp-UserSyncQueue-AccessPolicy-Name"; Value = $topicPolicyName; Encrypt = $false }
$variables += New-Object PSObject -Property @{ Name = "idmApp-UserSyncQueue-AccessPolicy-Key"; Value = $topicPolicyKey; Encrypt = $true }

foreach($var in $variables)
{
    # Ensure Variables
    $automationVar = Get-AzureRmAutomationVariable -Name $var.Name -ResourceGroupName $resourceGroupName -AutomationAccountName $automationAccountName -ErrorAction SilentlyContinue

    if(!$automationVar)
    {
        Write-Host "`tCreating variable [$($var.Name)]..." -NoNewline
        
        $automationVar = New-AzureRmAutomationVariable -Name $var.Name -ResourceGroupName $resourceGroupName -AutomationAccountName $automationAccountName `
                                      -Value $var.Value -Encrypted $var.Encrypt

        Write-Host " done." -ForegroundColor Green
    } else {
        Write-Host "`tVariable already exists [$($var.Name)] with value $(if(!$automationVar.Encrypted) {$automationVar.Value} else {'ENCRYPTED'})" 
    }
}
Write-Host "Done." -ForegroundColor Green;

Write-Host "`nProvision Automation Runbooks and Modules..." -ForegroundColor Cyan;

$HealthCheckRunbook = Import-AzureRmAutomationRunbook -AutomationAccountName $automationAccountName -ResourceGroupName $resourceGroupName `
                                                   -Path ".\SC-Mem-IDM-HealthCheck.ps1" -Type PowerShell -LogProgress $true -Force -Published

Write-Host "Health Check Runbook - State: $($HealthCheckRunbook.State)";

$FullSyncRunbook = Import-AzureRmAutomationRunbook -AutomationAccountName $automationAccountName -ResourceGroupName $resourceGroupName `
                                                   -Path ".\SC-Mem-IDM-FullSync.ps1" -Type PowerShell -LogProgress $true -Force -Published

Write-Host "Full Sync Runbook - State: $($FullSyncRunbook.State)";

# $DeltaSyncRunbook = Import-AzureRmAutomationRunbook -AutomationAccountName $automationAccountName -ResourceGroupName $resourceGroupName `
#                                                    -Path ".\SC-Mem-IDM-DeltaSync.ps1" -Type PowerShell -LogProgress $true -Force -Published

# Write-Host "Delta Sync Runbook - State: $($DeltaSyncRunbook.State)";

Write-Host "Done." -ForegroundColor Green;

Write-Host "`nMember Identity Sync Job Provisioning Complete" -ForegroundColor Green

#$accessToken = Get-GraphAccessToken -tenant $context.Tenant.TenantId -clientId $app.ApplicationId -clientSecret $psadCredential.Password 