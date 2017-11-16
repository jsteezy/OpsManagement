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
Ensure-Field $web.Url -FieldDef $global:FieldDefResponseCodesCode -ListContext $global:ListResponseCodes.Title -webContext $web.ID
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

function EnsureOMTResponses ()
{

    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

#region FIELDS

#General info
Ensure-Field $web.Url -FieldDef $global:regionalResponse -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:parentRegionalResponse -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:sitrepDate -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:nextSitrepDate -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:generalContext -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:recentContextDevelopment -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:responseUpdate -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:opsBackstop -ListContext $global:ListOMTReports.Title -webContext $web.ID

#Non SCI responses
Ensure-Field $web.Url -FieldDef $global:nonSciResponses -ListContext $global:ListOMTReports.Title -webContext $web.ID

#Reach figures
Ensure-Field $web.Url -FieldDef $global:affectedPopulation -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:strategyTarget -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:totalReachSinceStart -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:totalReachSinceLastSitrep -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:childrenReachedSinceStart -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:childrenReachedSinceLastSitrep -ListContext $global:ListOMTReports.Title -webContext $web.ID

#Income
Ensure-Field $web.Url -FieldDef $global:responseStrategyTarget -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:seedFundsTarget -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:seedFundsTargetDate -ListContext $global:ListOMTReports.Title -webContext $web.ID

#Deliverables
Ensure-Field $web.Url -FieldDef $global:assessmentBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:assessment -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:outlineBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:outline -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:strategyBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:strategy -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:planBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:plan -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:operationsControlReviewBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:operationsControlReview -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:realTimeReviewBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:realTimeReview -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:representationOnHCT -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:educationCluster -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:staffingEducationCluster -ListContext $global:ListOMTReports.Title -webContext $web.ID

#Sectors
Ensure-Field $web.Url -FieldDef $global:childProtectionBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:childProtectionBackstop -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:childProtectionSummary -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:educationBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:educationBackstop -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:educationSummary -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FSLBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FSLBackstop -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:FSLSummary -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:WASHBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:WASHBackstop -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:WASHSummary -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:shelterBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:shelterBackstop -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:shelterSummary -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:healthBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:healthBackstop -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:healthSummary -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:EHUUpdatesBool -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:EHUUpdates -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:EHUPresent -ListContext $global:ListOMTReports.Title -webContext $web.ID

#HR
Ensure-Field $web.Url -FieldDef $global:nationalStaffNumber -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:internationalStaffNumber -ListContext $global:ListOMTReports.Title -webContext $web.ID

#Saftey and security
Ensure-Field $web.Url -FieldDef $global:securityLevel -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:incidentSummary -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:securityEvents -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:securityContext -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:securityChallenges -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:securityManagement -ListContext $global:ListOMTReports.Title -webContext $web.ID

#Child safegaurding
Ensure-Field $web.Url -FieldDef $global:staffChildSafegaurding -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:safegaurdingFocalPoint -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:safegaurdingRisks -ListContext $global:ListOMTReports.Title -webContext $web.ID

#Advanced Media and Comms
Ensure-Field $web.Url -FieldDef $global:commsPack -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:mediaCoverage -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:spokespeople -ListContext $global:ListOMTReports.Title -webContext $web.ID

#Emergency supply chain 
Ensure-Field $web.Url -FieldDef $global:prepositionedStock -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:forThisResponse -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:plannedProcurement -ListContext $global:ListOMTReports.Title -webContext $web.ID
Ensure-Field $web.Url -FieldDef $global:procurementSpend -ListContext $global:ListOMTReports.Title -webContext $web.ID

#endregion

Ensure-ContentType -Url $web.Url -CTDef $global:CTDefOMTReports -FieldDefs $global:regionalResponse, $global:parentRegionalResponse,
$global:sitrepDate, $global:nextSitrepDate, $global:generalContext, $global:recentContextDevelopment, $global:responseUpdate, 
$global:opsBackstop, $global:nonSciResponses, $global:affectedPopulation, $global:strategyTarget, $global:totalReachSinceStart, 
$global:totalReachSinceLastSitrep, $global:childrenReachedSinceStart, $global:childrenReachedSinceLastSitrep, $global:responseStrategyTarget,
 $global:seedFundsTarget, $global:seedFundsTargetDate, $global:assessmentBool, $global:assessment, $global:outlineBool, $global:outline,
  $global:strategyBool, $global:strategy, $global:planBool, $global:plan, $global:operationsControlReviewBool, 
  $global:operationsControlReview, $global:realTimeReviewBool, $global:realTimeReview, $global:representationOnHCT, $global:educationCluster, 
  $global:staffingEducationCluster, $global:childProtectionBool, $global:childProtectionBackstop, $global:childProtectionSummary, 
  $global:educationBool, $global:educationBackstop, $global:educationSummary, $global:FSLBool, $global:FSLBackstop, $global:FSLSummary, 
  $global:WASHBool, $global:WASHBackstop, $global:WASHSummary, $global:shelterBool, $global:shelterBackstop, $global:shelterSummary, $global:healthBool, 
  $global:healthBackstop, $global:healthSummary, $global:EHUUpdatesBool, $global:EHUUpdates, $global:EHUPresent, $global:nationalStaffNumber, 
  $global:internationalStaffNumber, $global:securityLevel, $global:incidentSummary, $global:securityEvents, $global:securityContext, 
  $global:securityChallenges, $global:securityManagement, $global:staffChildSafegaurding, $global:safegaurdingFocalPoint, $global:safegaurdingRisks, 
  $global:commsPack, $global:mediaCoverage, $global:spokespeople, $global:prepositionedStock, $global:forThisResponse, $global:plannedProcurement, 
  $global:procurementSpend

Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListOMTReports

# #Ensure Lookup fields after the list has been created
# Ensure-Field -Url $web.Url -FieldDef $global:FieldDefOrgUnitsReportsTo -ListContext $global:ListOMTReports.Title -webContext $web.ID
# Ensure-Field -Url $web.Url -FieldDef $global:FieldDefOrgUnitsManagedBy -ListContext $global:ListCountries.Title -webContext $web.ID

# Ensure-ContentType -Url $web.Url -CTDef $global:CTDefOrgUnits -FieldDefs $global:FieldDefOrgUnitsReportsTo, $global:FieldDefOrgUnitsManagedBy

}
#endregion

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