#region Storage

function EnsureStorage()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )
    
    EnsureFeatures -web $web

    EnsureRegions -web $web

    EnsureCountries -web $web

    EnsureResponseCodes -web $web

    #EnsureOMTResponses -web $web

    EnsureOMTResponses -web $web
}

function EnsureFeatures() 
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    foreach ($featureName in $global:featuresToEnable)
    {
        $feature = Get-SPFeature -Web $web.Url -Identity $featureName -ErrorAction SilentlyContinue

        if ($feature -eq $null)
        {
            Enable-SPFeature -Url $web.Url -Identity $featureName -ErrorAction SilentlyContinue
        }
    }
}

function EnsureRegions()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefRegionsSecurityDirectorName -ListContext $global:ListRegions.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefRegionsSecurityDirectorAccount -ListContext $global:ListRegions.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefRegionsSecurityDirectorEmail -ListContext $global:ListRegions.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefRegions -FieldDefs $global:FieldDefRegionsSecurityDirectorName, $global:FieldDefRegionsSecurityDirectorAccount,
        $global:FieldDefRegionsSecurityDirectorEmail

    Configure-ContentTypeNonRequiredFields -Web $web -ContentTypeName $global:CTDefRegions.Name -FieldNames @($global:FieldDefRegionsSecurityDirectorName.InternalName, 
        $global:FieldDefRegionsSecurityDirectorAccount.InternalName,
        $global:FieldDefRegionsSecurityDirectorEmail.InternalName);

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListRegions
}

function EnsureCountries()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefCountriesIsoCode -ListContext $global:ListCountries.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefCountriesTravelRestrictions -ListContext $global:ListCountries.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefDirector -ListContext $global:ListCountries.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefRegionsLookup -ListContext $global:ListRegions.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefCountries -FieldDefs $global:FieldDefCountriesIsoCode,
        $global:FieldDefCountriesTravelRestrictions,
        $global:FieldDefDirector,
        $global:FieldDefRegionsLookup

    Configure-ContentTypeRequiredFields -Web $web -ContentTypeName $global:CTDefCountries.Name -FieldNames @($global:FieldDefDirector.InternalName)

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListCountries
}

#region Response Codes

function EnsureResponseCodes ()
{

    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

#region FIELDS
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesCode -ListContext $global:ListResponseCodes.InternalName -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesDescription -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesStartDate -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesRegion -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesCountry -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefUserProfileId -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefUserProfileEmail -ListContext $global:ListResponseCodes.Title -webContext $web.ID
#endregion

#endregion
Ensure-ContentType -Url $web.Url -CTDef $global:CTDefResponseCodes -FieldDefs $global:FieldDefResponseCodesCode, $global:FieldDefResponseCodesDescription, 
$global:FieldDefResponseCodesStartDate, $global:FieldDefResponseCodesRegion, $global:FieldDefResponseCodesCountry, $global:FieldDefUserProfileId, 
$global:FieldDefUserProfileEmail

Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListResponseCodes

}
#region OMT Reports


#region Authorization

function EnsureAuthorization()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    $groupNames = Get-SecurityGroupNames

    EnsureGroups -web $web -GroupNames $groupNames
}

function EnsureGroups()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web,
    [Parameter(Mandatory=$true)]
    [string[]]$GroupNames
    )

    foreach ($groupName in $GroupNames)
    {
        $groupNameEnum = $global:TARSecurityGroups[$groupName];
        
        $groupDescription = $groupNameEnum["description"];
        $groupRole = $groupNameEnum["role"];
        $groupOwnerName = $groupNameEnum["owners"];

        if ($groupOwnerName -eq $null) 
        {
            $groupOwnerName = $groupName
        }

        #check if group exists
        $group = $web.SiteGroups[$groupName];
        if ($group -eq $null)
        {
            Log "$($groupName) does not exist, begin creation..." -Level Warning

            $web.SiteGroups.Add($groupName, $web.Site.Owner, $web.Site.Owner, $groupDescription);

            Log "Group created." -Level Success
        
            $group = $web.SiteGroups[$groupName];
            $group.Owner = $web.SiteGroups[$groupOwnerName];
            $group.AllowMembersEditMembership = $false;
            $group.OnlyAllowMembersViewMembership = $false;
            $group.Update();

            $roleDefinition = $web.RoleDefinitions[$groupRole];
            $roleAssignment = New-Object Microsoft.SharePoint.SPRoleAssignment($group);
            $roleAssignment.RoleDefinitionBindings.Add($roleDefinition);

            $web.RoleAssignments.Add($roleAssignment);
        }
    }

    $web.Update();
}

function SetListPermissionsForGroups
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web
    )

    SetListPermissionForGroup -Web $Web -ListName $global:TARRequestsListTitle -GroupName $global:TARAllUsersGroupName -Role "Contribute"
    SetListPermissionForGroup -Web $Web -ListName $global:TARDraftsListTitle -GroupName $global:TARAllUsersGroupName -Role "Contribute"
    SetListPermissionForGroup -Web $Web -ListName $global:EIFRequestsListTitle -GroupName $global:TARAllUsersGroupName -Role "Contribute"
    SetListPermissionForGroup -Web $Web -ListName $global:EIFDraftsListTitle -GroupName $global:TARAllUsersGroupName -Role "Contribute"
    SetListPermissionForGroup -Web $Web -ListName $global:WorkflowHistoryListTitle -GroupName $global:TARAllUsersGroupName -Role "Contribute"
    SetListPermissionForGroup -Web $Web -ListName $global:WorkflowTasksListTitle -GroupName $global:TARAllUsersGroupName -Role "Contribute"

    $userProfileListNames = $Web.Lists | Where {$_.Title -like "User Profile*"} | Select -Property Title;
    foreach ($profileListName in $userProfileListNames) 
    {
        SetListPermissionForGroup -Web $Web -ListName $profileListName.Title -GroupName $global:TARAllUsersGroupName -Role "Contribute"
    }
}

#endregion 


function EnsureOMTResponses() 
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesRegionalResponse -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesParentRegionalResponse -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSitrepDate -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesNextSitrepDate -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesGeneralContext -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesRecentContextDevelopment -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesResponseUpdate -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesOpsBackstop -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesNonSciResponses -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesAffectedPopulation -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesStrategyTarget -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesTotalReachSinceStart -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesTotalReachSinceLastSitrep -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesChildrenReachedSinceStart -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesChildrenReachedSinceLastSitrep -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesResponseStrategyTarget -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSeedFundsTarget -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSeedFundsTargetDate -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesAssessment -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesOutline -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesStrategy -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesPlan -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesOperationsControlReview -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesRealTimeReview -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesRepresentationOnHCT -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesEducationCluster -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesStaffingEducationCluster -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesChildProtectionBackstop -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesChildProtectionSummary -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesEducationBackstop -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesEducationSummary -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesFSLBackstop -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesFSLSummary -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesWASHBackstop -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesWASHSummary -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesShelterBackstop -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesShelterSummary -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesHealthBackstop -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesHealthSummary  -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesEHUUpdates -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesEHUPresent -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesNationalStaffNumber -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesInternationalStaffNumber -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSecurityLevel -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesIncidentSummary -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSecurityEvents -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSecurityContext -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSecurityChallenges -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSecurityManagement -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesStaffChildSafegaurding -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSafegaurdingFocalPoint -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSafegaurdingRisks -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesCommsPack -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesMediaCoverage -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesSpokespeople -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesPrepositionedStock -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesForThisResponse -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesPlannedProcurement -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefOMTResponsesProcurementSpend -ListContext $global:ListOMTResponses.Title -webContext $web.ID
    
    
    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefOMTResponses -FieldDefs $global:FieldDefOMTResponsesRegionalResponse, 
    $global:FieldDefOMTResponsesParentRegionalResponse, 
    $global:FieldDefOMTResponsesSitrepDate, 
    $global:FieldDefOMTResponsesNextSitrepDate, 
    $global:FieldDefOMTResponsesGeneralContext, 
    $global:FieldDefOMTResponsesRecentContextDevelopment, 
    $global:FieldDefOMTResponsesResponseUpdate, 
    $global:FieldDefOMTResponsesOpsBackstop, 
    $global:FieldDefOMTResponsesNonSciResponses, 
    $global:FieldDefOMTResponsesAffectedPopulation, 
    $global:FieldDefOMTResponsesStrategyTarget, 
    $global:FieldDefOMTResponsesTotalReachSinceStart, 
    $global:FieldDefOMTResponsesTotalReachSinceLastSitrep, 
    $global:FieldDefOMTResponsesChildrenReachedSinceStart, 
    $global:FieldDefOMTResponsesChildrenReachedSinceLastSitrep, 
    $global:FieldDefOMTResponsesResponseStrategyTarget, 
    $global:FieldDefOMTResponsesSeedFundsTarget, 
    $global:FieldDefOMTResponsesSeedFundsTargetDate, 
    $global:FieldDefOMTResponsesAssessment, 
    $global:FieldDefOMTResponsesOutline, 
    $global:FieldDefOMTResponsesStrategy,
    $global:FieldDefOMTResponsesPlan, 
    $global:FieldDefOMTResponsesOperationsControlReview, 
    $global:FieldDefOMTResponsesRealTimeReview, 
    $global:FieldDefOMTResponsesRepresentationOnHCT, 
    $global:FieldDefOMTResponsesEducationCluster, 
    $global:FieldDefOMTResponsesStaffingEducationCluster, 
    $global:FieldDefOMTResponsesChildProtectionBackstop, 
    $global:FieldDefOMTResponsesChildProtectionSummary, 
    $global:FieldDefOMTResponsesEducationBackstop, 
    $global:FieldDefOMTResponsesEducationSummary, 
    $global:FieldDefOMTResponsesFSLBackstop, 
    $global:FieldDefOMTResponsesFSLSummary, 
    $global:FieldDefOMTResponsesWASHBackstop, 
    $global:FieldDefOMTResponsesWASHSummary, 
    $global:FieldDefOMTResponsesShelterBackstop, 
    $global:FieldDefOMTResponsesShelterSummary, 
    $global:FieldDefOMTResponsesHealthBackstop, 
    $global:FieldDefOMTResponsesHealthSummary , 
    $global:FieldDefOMTResponsesEHUUpdates, 
    $global:FieldDefOMTResponsesEHUPresent, 
    $global:FieldDefOMTResponsesNationalStaffNumber, 
    $global:FieldDefOMTResponsesInternationalStaffNumber, 
    $global:FieldDefOMTResponsesSecurityLevel, 
    $global:FieldDefOMTResponsesIncidentSummary, 
    $global:FieldDefOMTResponsesSecurityEvents, 
    $global:FieldDefOMTResponsesSecurityContext, 
    $global:FieldDefOMTResponsesSecurityChallenges, 
    $global:FieldDefOMTResponsesSecurityManagement, 
    $global:FieldDefOMTResponsesStaffChildSafegaurding, 
    $global:FieldDefOMTResponsesSafegaurdingFocalPoint, 
    $global:FieldDefOMTResponsesSafegaurdingRisks, 
    $global:FieldDefOMTResponsesCommsPack, 
    $global:FieldDefOMTResponsesMediaCoverage, 
    $global:FieldDefOMTResponsesSpokespeople, 
    $global:FieldDefOMTResponsesPrepositionedStock, 
    $global:FieldDefOMTResponsesForThisResponse, 
    $global:FieldDefOMTResponsesPlannedProcurement, 
    $global:FieldDefOMTResponsesProcurementSpend

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListOMTResponses
}