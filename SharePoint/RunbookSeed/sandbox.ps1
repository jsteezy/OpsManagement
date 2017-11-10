#New-AzureRmADAppCredential -ObjectId "ae2941ec-b650-4f80-842d-39b3fa4d1154" -StartDate $startDate -EndDate $endDate -Password "somepassword"
    #Get-AzureRmADAppCredential -ApplicationId "b67a958a-3e94-4410-8fa4-e941e0082be2"

    #  $appCred = New-AzureADApplicationPasswordCredential -ObjectId $app.ObjectId -CustomKeyIdentifier "AA-SyncJobAppKey" `
    #                                           -StartDate $startDate -EndDate $endDate -

    # $graphService = Get-AzureADServicePrincipal -SearchString "Microsoft.Azure.AgregatorService" 
# $graphService.AppRoles

Get-AzureRmADApplication -DisplayNameStartWith "SCI - Member"

Write-Host "Delete resource group"
Remove-AzureRmResourceGroup -Name "SCI-MemberIdentity-Sync"
Remove-AzureRmADApplication -ObjectId "57a9498a-ebc7-4b92-9abc-4d917f90359c"