﻿#region Storage

function EnsureStorage()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )
    
    EnsureFeatures -web $web

    EnsureSolutionStorage -web $web -docLibraryName $global:solutionStorageDocLibraryName    

    #EnsureRegions -web $web

    #EnsureCountries -web $web

    EnsureResponseCodes -web $web

    EnsureReports -web $web
}

function EnsureSolutionStorage()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web,
    [string]$docLibraryName
    )

    Start-SPAssignment -Global

    $listCollection = $web.Lists;

    $storageLibrary = $listCollection.TryGetList($docLibraryName);

    if ($storageLibrary -ne $null) 
    {
        Log "Library $($docLibraryName) already exists" -Level Warning
    }
    else
    {
        Log "Creating library $($docLibraryName)" -Level Warning

        $listCollection.Add($docLibraryName, "Dedicated document library for storing the OMT app solution.", [Microsoft.SharePoint.SPListTemplateType]::DocumentLibrary)

        Log "Document library created..." -Level Success
    }

    Stop-SPAssignment -Global
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

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefRegionsName -ListContext $global:ListRegions.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefRegions -FieldDefs $global:FieldDefRegionsName

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
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesCode -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesDescription -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesStartDate -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesRegion -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesCountry -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesResponseStatus -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesCategory -ListContext $global:ListResponseCodes.Title -webContext $web.ID    
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesPhase -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesStrategyDate -ListContext $global:ListResponseCodes.Title -webContext $web.ID    
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesStrategyNumber -ListContext $global:ListResponseCodes.Title -webContext $web.ID    
Ensure-Field $web.Url -FieldDef $global:FieldDefUserProfileId -ListContext $global:ListResponseCodes.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FieldDefUserProfileEmail -ListContext $global:ListResponseCodes.Title -webContext $web.ID


#endregion

#endregion
Ensure-ContentType -Url $web.Url -CTDef $global:CTDefResponseCodes -FieldDefs $global:FieldDefResponseCodesCode, $global:FieldDefResponseCodesDescription, 
$global:FieldDefResponseCodesStartDate, $global:FieldDefResponseCodesRegion, $global:FieldDefResponseCodesCountry, $global:FieldDefResponseCodesResponseStatus,
$global:FieldDefResponseCodesCategory, $global:FieldDefResponseCodesPhase, $global:FieldDefResponseCodesStrategyDate, $global:FieldDefResponseCodesStrategyNumber,
$global:FieldDefUserProfileId,  $global:FieldDefUserProfileEmail

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
        $groupNameEnum = $global:OMTSecurityGroups[$groupName];
        
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

#region Non SCI managed responses

#endregion

function EnsureReports() 
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSecuredIncome -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsNewAwards -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsResponsePipeline -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsResponsePipelineAppeal -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSeedFundsSecured -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSeedFundsSecuredYearly -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsCSF -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsResponseTotalSpend -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsTotalSpendAgainstCSF -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsTotalSpendThroughPartners -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsTotalSpendThroughCTP -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsTotalSpendEducation -ListContext $global:ListReports.Title -webContext $web.ID
    #region FIELDS
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsStatus -ListContext $global:ListReports.Title -webContext $web.ID    
    Ensure-Field $web.Url -FieldDef $global:FieldDefResponseId -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSitrepDate -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsNextSitrepDate -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsOpsBackstop -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSitrepNumber -ListContext $global:ListReports.Title -webContext $web.ID      
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsGeneralContextInternal -ListContext $global:ListReports.Title -webContext $web.ID    
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsGeneralContextExternal -ListContext $global:ListReports.Title -webContext $web.ID    
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsResponseUpdateInternal -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsResponseUpdateExternal -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsChallengesInternal -ListContext $global:ListReports.Title -webContext $web.ID
   
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsNonSciResponses -ListContext $global:ListReports.Title -webContext $web.ID

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsAffectedPopulation -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsAffectedChildren -ListContext $global:ListReports.Title -webContext $web.ID  
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsStrategyTarget -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsTotalReachSinceStart -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsTotalReachSinceLastSitrep -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsChildrenReachedSinceStart -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsChildrenReachedSinceLastSitrep -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsStrategyTargetChildren -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsChildrenReachInCurrentYear -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsTotalReachInCurrentYear -ListContext $global:ListReports.Title -webContext $web.ID

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsResponseStrategyTarget -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSeedFundsTarget -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSeedFundsTargetDate -ListContext $global:ListReports.Title -webContext $web.ID

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsCrisisModifiers -ListContext $global:ListReports.Title -webContext $web.ID    

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsAssessment -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsOutline -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsStrategy -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsPlan -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsOperationsControlReview -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsRealTimeReview -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsRepresentationOnHCTBool -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsEducationClusterBool -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsStaffingEducationClusterBool -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSciLeadingEducationClusterBool -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsPercentTimeToEducationCluster -ListContext $global:ListReports.Title -webContext $web.ID

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsChildProtectionBackstop -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsChildProtectionSummary -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsEducationBackstop -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsEducationSummary -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsFSLBackstop -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsFSLSummary -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsWASHBackstop -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsWASHSummary -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsShelterBackstop -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsShelterSummary -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsHealthBackstop -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsHealthSummary  -ListContext $global:ListReports.Title -webContext $web.ID

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsEHUDeployed -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsEHUDeployedDate -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsEHUDeployedUntilDate -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsOutputTracker -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsNutritionSummary -ListContext $global:ListReports.Title -webContext $web.ID    
    

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsNationalStaffNumber -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsInternationalStaffNumber -ListContext $global:ListReports.Title -webContext $web.ID

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsDeploymentTrackerLink -ListContext $global:ListReports.Title -webContext $web.ID    

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSecurityContext -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSecurityChallenges -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSecurityManagement -ListContext $global:ListReports.Title -webContext $web.ID

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsStaffChildSafegaurding -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSafegaurdingFocalPoint -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSafegaurdingRisks -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsCommsPack -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsMediaCoverage -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsSpokespeople -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsContentHubLink -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsLatestMediaLink -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsAdvocacyActions -ListContext $global:ListReports.Title -webContext $web.ID    

    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsPrepositionedStock -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsForThisResponse -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsPlannedProcurement -ListContext $global:ListReports.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReportsProcurementSpend -ListContext $global:ListReports.Title -webContext $web.ID

    Ensure-Field $web.Url -FieldDef $global:FieldDefUserProfileId -ListContext $global:ListResponseCodes.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefUserProfileEmail -ListContext $global:ListResponseCodes.Title -webContext $web.ID    
    
    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefReports -FieldDefs $global:FieldDefReportsStatus,
    $global:FieldDefResponseId,

    $global:FieldDefReportsSitrepDate,
    $global:FieldDefReportsNextSitrepDate,
    $global:FieldDefReportsOpsBackstop,
    $global:FieldDefReportsSitrepNumber,      
    $global:FieldDefReportsGeneralContextInternal,    
    $global:FieldDefReportsGeneralContextExternal,    
    $global:FieldDefReportsResponseUpdateInternal,
    $global:FieldDefReportsResponseUpdateExternal,
    $global:FieldDefReportsChallengesInternal,
       
    $global:FieldDefReportsNonSciResponses,
    
    $global:FieldDefReportsAffectedPopulation,
    $global:FieldDefReportsAffectedChildren,
    $global:FieldDefReportsStrategyTarget,
    $global:FieldDefReportsTotalReachSinceStart,
    $global:FieldDefReportsTotalReachSinceLastSitrep,
    $global:FieldDefReportsChildrenReachedSinceStart,
    $global:FieldDefReportsChildrenReachedSinceLastSitrep,    
    $global:FieldDefReportsStrategyTargetChildren,
    $global:FieldDefReportsChildrenReachInCurrentYear,
    $global:FieldDefReportsTotalReachInCurrentYear,
    
    $global:FieldDefReportsResponseStrategyTarget,
    $global:FieldDefReportsSeedFundsTarget,
    $global:FieldDefReportsSeedFundsTargetDate,
    
    $global:FieldDefReportsCrisisModifiers,    
    
    $global:FieldDefReportsAssessment,
    $global:FieldDefReportsOutline,
    $global:FieldDefReportsStrategy,
    $global:FieldDefReportsPlan,
    $global:FieldDefReportsOperationsControlReview,
    $global:FieldDefReportsRealTimeReview,
    $global:FieldDefReportsRepresentationOnHCTBool,
    $global:FieldDefReportsEducationClusterBool,
    $global:FieldDefReportsStaffingEducationClusterBool,
    $global:FieldDefReportsSciLeadingEducationClusterBool,
    $global:FieldDefReportsPercentTimeToEducationCluster,
    
    $global:FieldDefReportsChildProtectionBackstop,
    $global:FieldDefReportsChildProtectionSummary,
    $global:FieldDefReportsEducationBackstop,
    $global:FieldDefReportsEducationSummary,
    $global:FieldDefReportsFSLBackstop,
    $global:FieldDefReportsFSLSummary,
    $global:FieldDefReportsWASHBackstop,
    $global:FieldDefReportsWASHSummary,
    $global:FieldDefReportsShelterBackstop,
    $global:FieldDefReportsShelterSummary,
    $global:FieldDefReportsHealthBackstop,
    $global:FieldDefReportsHealthSummary ,
    
    $global:FieldDefReportsEHUDeployed,
    $global:FieldDefReportsEHUDeployedDate,
    $global:FieldDefReportsEHUDeployedUntilDate,
    $global:FieldDefReportsOutputTracker,
    $global:FieldDefReportsNutritionSummary,    
        
    
    $global:FieldDefReportsNationalStaffNumber,
    $global:FieldDefReportsInternationalStaffNumber,
    
    $global:FieldDefReportsDeploymentTrackerLink,    
    
    $global:FieldDefReportsSecurityContext,
    $global:FieldDefReportsSecurityChallenges,
    $global:FieldDefReportsSecurityManagement,
    
    $global:FieldDefReportsStaffChildSafegaurding,
    $global:FieldDefReportsSafegaurdingFocalPoint,
    $global:FieldDefReportsSafegaurdingRisks,
    $global:FieldDefReportsCommsPack,
    $global:FieldDefReportsMediaCoverage,
    $global:FieldDefReportsSpokespeople,
    $global:FieldDefReportsContentHubLink,
    $global:FieldDefReportsLatestMediaLink,
    
    $global:FieldDefReportsAdvocacyActions,    
    
    $global:FieldDefReportsPrepositionedStock,
    $global:FieldDefReportsForThisResponse,
    $global:FieldDefReportsPlannedProcurement,
    $global:FieldDefReportsProcurementSpend,
    $global:FieldDefUserProfileEmail,
    $global:FieldDefUserProfileId,

    $global:FieldDefReportsSecuredIncome,
    $global:FieldDefReportsNewAwards,
    $global:FieldDefReportsResponsePipeline,
    $global:FieldDefReportsResponsePipelineAppeal,
    $global:FieldDefReportsSeedFundsSecured,
    $global:FieldDefReportsSeedFundsSecuredYearly,
    $global:FieldDefReportsCSF,
    $global:FieldDefReportsResponseTotalSpend,
    $global:FieldDefReportsTotalSpendAgainstCSF,
    $global:FieldDefReportsTotalSpendThroughPartners,
    $global:FieldDefReportsTotalSpendThroughCTP,
    $global:FieldDefReportsTotalSpendEducation

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListReports
}