#region Authorization

$global:TARManagementGroupName = "_TAR Management_";
$global:TARSystemAdminGroupName = "_System Admin_";
$global:OMTApproverGroupName = "Approver";
$global:TARAllUsersGroupName = "_All TAR Users_";
$global:TARBudgetApproversGroupName = "Budget Approvers";
$global:TARBudgetApproversManagementGroupName = "TAR Budget Approvers Management";
$global:TARSuperBudgetApproversGroupName = "Super Budget Approvers";
$global:TARGSSApproversGroupName = "GSS Approvers";
$global:TARGSSSiteAdminGroupName = "GSS Site Admin";
$global:TARFinanceGroupName = "TAR Finance";
$global:TARExecutivePersonalAssistants = "Executive and Personal Assistants";

$global:TARSecurityGroups = @{
        $global:TARSystemAdminGroupName = @{ 
            "description" = "TAR Application System Administrator"
            "role" = "Full Control" 
            }
            $global:OMTApproverGroupName = @{ 
                "description" = "OMT Approvers"
                "role" = "Approve" 
                }
        $global:TARManagementGroupName = @{ 
            "description" = "TAR Application Management"
            "role" = "Contribute"
            }
        $global:TARAllUsersGroupName = @{ 
            "description" = "TAR Application All Users"
            "role" = "Read"
            }
        $global:TARBudgetApproversManagementGroupName = @{
            "description" = "TAR Budget Approvers Management"
            "role" = "Full Control"
            }
        $global:TARBudgetApproversGroupName = @{
            "description" = "TAR Budget Approvers"
            "role" = "Approve"
            "owners" = $global:TARBudgetApproversManagementGroupName
            }
        $global:TARExecutivePersonalAssistants = @{
            "description" = "TAR Executive and Personal Assistants"
            "role" = "Approve"
            "owners" = $global:TARBudgetApproversManagementGroupName
            }
        $global:TARSuperBudgetApproversGroupName = @{
            "description" = "TAR Super Budget Approvers"
            "role" = "Approve"
            "owners" = $global:TARBudgetApproversManagementGroupName
            }
        $global:TARGSSSiteAdminGroupName = @{
            "description" = "TAR GSS Site Admins"
            "role" = "Full Control"
            }
        $global:TARGSSApproversGroupName = @{
            "description" = "TAR GSS Approvers"
            "role" = "Approve"
            "owners" = $global:TARGSSSiteAdminGroupName
            }
        $global:TARFinanceGroupName = @{
            "description" = "TAR Finance"
            "role" = "Contribute"
            }
    }; 

#Groups must be returned in the order of their creation (ex: GSS SiteAdmin must be before GSS Approvers because they are the owners)
function Get-SecurityGroupNames
{
    Write-Output @($global:TARManagementGroupName, $global:TARSystemAdminGroupName, $global:OMTApproverGroupName, $global:TARBudgetApproversManagementGroupName, $global:TARAllUsersGroupName,  
        $global:TARBudgetApproversGroupName, $global:TARSuperBudgetApproversGroupName, $global:TARGSSSiteAdminGroupName, $global:TARGSSApproversGroupName,
        $global:TARFinanceGroupName, $global:TARExecutivePersonalAssistants);
}

#endregion 

#region Lists Collection
function Get-ListNames
{
    Write-Output @($global:RegionsListTitle, $global:CountriesListTitle, $global:OMTReportsListTitle);
}

#endregion


#region Regions

$global:RegionsListTitle = "Regions";
$global:RegionsListName = "Regions";

$global:FieldDefRegionsSecurityDirectorName = New-FieldDefinition @'
    <Field ID="{DC36311B-C563-43C9-AA16-C1989008720B}" Type="Text" MaxLength="255" Name="TAR_SecurityDirectorName" StaticName="TAR_SecurityDirectorName" DisplayName="Security Director Name"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefRegionsSecurityDirectorAccount = New-FieldDefinition @'
    <Field ID="{9EF95FFD-407A-4C39-AD66-AA95E08A5A01}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_SecurityDirectorAccount" StaticName="TAR_SecurityDirectorAccount" DisplayName="Security Director Account"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefRegionsSecurityDirectorEmail = New-FieldDefinition @'
    <Field ID="{2D88B0C4-E45F-4008-850A-B4BED585D7D6}" Type="Text" MaxLength="255" Name="TAR_SecurityDirectorEmail" StaticName="TAR_SecurityDirectorEmail" DisplayName="Security Director Email"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefRegions = New-ContentTypeDefinition -ID "0x0100DFA3462A212A4D6E9B058DEBF1EC7875" -Name "Regions" -Group $CTGroup -Description "TAR Regions";

$global:ListRegions = New-ListDefinition -ListTitle $global:RegionsListTitle -ListUrl $global:RegionsListName -Description "Regions for TAR" -Template $CustomListTemplate -ContentTypes @($global:CTDefRegions.Name);

#endregion

#region Countries

$global:CountriesListTitle = "Countries";
$global:CountriesListName = "Countries";

$global:FieldDefCountriesIsoCode = New-FieldDefinition @'
    <Field ID="{B51CF4B4-DBAA-4872-8FE0-9D3AD2986655}" Type="Text" MaxLength="3" Name="TAR_IsoCode" StaticName="TAR_IsoCode" DisplayName="ISO Code" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefCountriesTravelRestrictions = New-FieldDefinition @'
    <Field ID="{655BCA8C-9746-4C4D-8DA5-3972C1BEF689}" Type="Boolean" Name="TAR_TravelRestrictions" StaticName="TAR_TravelRestrictions" DisplayName="Travel Restrictions Apply"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE">
        <DefaultValue>No</DefaultValue>
    </Field>
'@;

$global:CTDefCountries = New-ContentTypeDefinition -ID "0x01006DCCD19E51BB4150801B37729FBC9CCB" -Name "Countries" -Group $CTGroup -Description "TAR Countries";

$global:ListCountries = New-ListDefinition -ListTitle $global:CountriesListTitle -ListUrl $global:CountriesListName -Description "Countries for TAR" -Template $CustomListTemplate -ContentTypes @($global:CTDefCountries.Name);

#endregion

#region OMT Report List

$global:OMTReportsListName = "OMTReports";
$global:OMTReportsListTitle = "OMT Reports";

$global:FieldDefOMTReportsId = New-FieldDefinition -FieldXml @'
<Field ID="{6fe266c5-8ab3-4a82-8bab-784180135f50}" Type="Number" Decimals="0" Name="UserId" StaticName="UserId" DisplayName="User ID" 
    Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEmail = New-FieldDefinition -FieldXml @'
    <Field ID="{b6ae2134-be39-4282-8a50-00690b056e25}" Type="Text" MaxLength="255" Name="UserEmail" StaticName="UserEmail" DisplayName="User Email" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

###### General questions

$global:FieldDefOMTReportsRegionalResponse = New-FieldDefinition -FieldXml @'
    <Field ID="{a341e8a0-95c5-4512-a2ba-27645ee377d4}" Type="Boolean" Name="RegionalResponse" StaticName="RegionalResponse" DisplayName="Regional Response" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsParentRegionalResponse = New-FieldDefinition -FieldXml @'
    <Field ID="{d0096bff-1f3f-43cc-a7f5-74f1cd4bd212}" Type="Text" MaxLength="255" Name="ParentRegionalResponse" StaticName="ParentRegionalResponse" DisplayName="Parent Regional Response" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSitrepDate = New-FieldDefinition -FieldXml @'
    <Field ID="{D7CC926E-5702-48A3-A133-5F971E78FBA7}" Type="DateTime" Name="SitrepDate" StaticName="SitrepDate" DisplayName="Sitrep Date" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsNextSitrepDate = New-FieldDefinition -FieldXml @'
<Field ID="{147fbb97-8264-485b-bdfd-8fd7e4244105}" Type="DateTime" Name="NextSitrepDate" StaticName="NextSitrepDate" DisplayName="Next Sitrep Date" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsGeneralContext = New-FieldDefinition -FieldXml @'
<Field ID="{c4043b00-0f1a-4de8-a2fe-35a39ffff505}" Type="Text" MaxLength="255" Name="GeneralContext" StaticName="GeneralContext" DisplayName="General Context" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRecentContextDevelopment = New-FieldDefinition -FieldXml @'
<Field ID="{fd42f03a-1d7b-45a5-99d2-1e35c761c861}" Type="Text" MaxLength="255" Name="RecentContextDevelopment" StaticName="RecentContextDevelopment" DisplayName="Recent Context Development" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsResponseUpdate = New-FieldDefinition -FieldXml @'
<Field ID="{b1f0815a-c44e-4e90-b46d-547b38621313}" Type="Text" MaxLength="255" Name="ResponseUpdate" StaticName="ResponseUpdate" DisplayName="Response Update" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOpsBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{0a221a2d-5ce1-476b-84e8-bd01dfcde530}" Type="Text" MaxLength="255" Name="OpsBackstop" StaticName="OpsBackstop" DisplayName="Ops Backstop" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#### Non SCI responses

$global:FieldDefOMTReportsNonSciResponses = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="NonSciResponses" StaticName="NonSciResponses" DisplayName="Non SCI Responses" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

####### Reach figures

$global:FieldDefOMTReportsAffectedPopulation = New-FieldDefinition -FieldXml @'
<Field ID="{e9bbc06d-3fdf-4f9a-a252-577d18764da2}" Type="Number" Decimals="0" Name="AffectedPopulation" StaticName="AffectedPopulation" DisplayName="Affected Population" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsStrategyTarget = New-FieldDefinition -FieldXml @'
<Field ID="{4c11753d-ec91-45a7-b10a-138e14340ced}" Type="Number" Decimals="0" Name="StrategyTarget" StaticName="StrategyTarget" DisplayName="Strategy Target" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsTotalReachSinceStart = New-FieldDefinition -FieldXml @'
<Field ID="{4ef71399-3520-46b8-873e-1492a1d81543}" Type="Number" Decimals="0" Name="TotalReachSinceStart" StaticName="TotalReachSinceStart" DisplayName="Total Reach Since Start" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsTotalReachSinceLastSitrep = New-FieldDefinition -FieldXml @'
<Field ID="{a87e840f-de9d-4e31-9f49-aec5ecab169b}" Type="Number" Decimals="0" Name="TotalReachSinceLastSitrep" StaticName="TotalReachSinceLastSitrep" DisplayName="Total Reach Since Last Sitrep" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsChildrenReachedSinceStart = New-FieldDefinition -FieldXml @'
<Field ID="{9c144ade-0057-4b8d-a097-f91a172f0a17}" Type="Number" Decimals="0" Name="ChildrenReachedSinceStart" StaticName="ChildrenReachedSinceStart" DisplayName="Children Reached Since Start" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsChildrenReachedSinceLastSitrep = New-FieldDefinition -FieldXml @'
<Field ID="{0341a32f-d256-4694-b6c1-2aa48051a2e5}" Type="Number" Decimals="0" Name="ChildrenReachedSinceLastSitrep" StaticName="ChildrenReachedSinceLastSitrep" DisplayName="Children Reached Since Last Sitrep" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

########## Income

$global:FieldDefOMTReportsResponseStrategyTarget = New-FieldDefinition -FieldXml @'
<Field ID="{f11914b3-f3bf-41f9-8973-d1933ecf7e91}" Type="Number" Decimals="0" Name="ResponseStrategyTarget" StaticName="ResponseStrategyTarget" DisplayName="Response Strategy Target" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSeedFundsTarget = New-FieldDefinition -FieldXml @'
<Field ID="{df761917-c4fa-4b64-bef3-c0fb56492293}" Type="Number" Decimals="0" Name="SeedFundsTarget" StaticName="SeedFundsTarget" DisplayName="Seed Funds Target" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSeedFundsTargetDate = New-FieldDefinition -FieldXml @'
<Field ID="{c03e44a4-b34e-4933-805f-a8b3938d7473}" Type="DateTime" Name="SeedFundsTargetDate" StaticName="SeedFundsTargetDate" DisplayName="Seed Funds Target Date" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

######### Deliverables

$global:FieldDefOMTReportsAssessmentBool = New-FieldDefinition -FieldXml @'
<Field ID="{2b5c66f8-8ffb-400b-8235-a6e22008b282}" Type="Boolean" Name="AssessmentBool" StaticName="AssessmentBool" DisplayName="Assessment Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsAssessment = New-FieldDefinition -FieldXml @'
<Field ID="{8e956619-ca49-4a90-80d2-c3476cd988c0}" Type="Text" MaxLength="255" Name="Assessment" StaticName="Assessment" DisplayName="Assessment" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOutlineBool = New-FieldDefinition -FieldXml @'
<Field ID="{b97b080e-3e47-44dc-833c-aca13f53ac22}" Type="Boolean" Name="OutlineBool" StaticName="OutlineBool" DisplayName="Outline Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOutline = New-FieldDefinition -FieldXml @'
<Field ID="{7b564c2c-5c14-4c57-9ff9-90c9e377aa45}" Type="Text" MaxLength="255" Name="Outline" StaticName="Outline" DisplayName="Outline" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsStrategyBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="StrategyBool" StaticName="StrategyBool" DisplayName="Strategy Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsStrategy = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="Strategy" StaticName="Strategy" DisplayName="Strategy" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsPlanBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="PlanBool" StaticName="PlanBool" DisplayName="Plan Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsPlan = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="Plan" StaticName="Plan" DisplayName="Plan" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOperationsControlReviewBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="OperationsControlReviewBool" StaticName="OperationsControlReviewBool" DisplayName="Operations Control Review Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOperationsControlReview = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="OperationsControlReview" StaticName="OperationsControlReview" DisplayName="Operations Control Review" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRealTimeReviewBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="RealTimeReviewBool" StaticName="RealTimeReviewBool" DisplayName="Real Time Review Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRealTimeReview = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="RealTimeReview" StaticName="RealTimeReview" DisplayName="Real Time Review" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRepresentationOnHCT = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="RepresentationOnHCT" StaticName="RepresentationOnHCT" DisplayName="Representation On HCT" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationCluster = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="EducationCluster" StaticName="EducationCluster" DisplayName="Education Cluster" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsStaffingEducationCluster = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="StaffingEducationCluster" StaticName="StaffingEducationCluster" DisplayName="Staffing Education Cluster" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

######## Sectors

$global:FieldDefOMTReportsChildProtectionBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="ChildProtectionBool" StaticName="ChildProtectionBool" DisplayName="Child Protection Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsChildProtectionBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="ChildProtectionBackstop" StaticName="ChildProtectionBackstop" DisplayName="Child Protection Backstop" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsChildProtectionSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="ChildProtectionSummary" StaticName="ChildProtectionSummary" DisplayName="Child Protection Summary" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="EducationBool" StaticName="EducationBool" DisplayName="Education Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="EducationBackstop" StaticName="EducationBackstop" DisplayName="Education Backstop" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="EducationSummary" StaticName="EducationSummary" DisplayName="Education Summary" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsFSLBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="FSLBool" StaticName="FSLBool" DisplayName="FSLBool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsFSLBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="FSLBackstop" StaticName="FSLBackstop" DisplayName="FSL Backstop" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsFSLSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="FSLSummary" StaticName="FSLSummary" DisplayName="FSL Summary" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsWASHBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="WASHBool" StaticName="WASHBool" DisplayName="WASH Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsWASHBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="WASHBackstop" StaticName="WASHBackstop" DisplayName="WASH Backstop" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsWASHSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="WASHSummary" StaticName="WASHSummary" DisplayName="WASH Summary" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsShelterBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="ShelterBool" StaticName="ShelterBool" DisplayName="Shelter Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsShelterBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="ShelterBackstop" StaticName="ShelterBackstop" DisplayName="Shelter Backstop" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsShelterSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="ShelterSummary" StaticName="ShelterSummary" DisplayName="Shelter Summary" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsHealthBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="HealthBool" StaticName="HealthBool" DisplayName="Health Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsHealthBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="HealthBackstop" StaticName="HealthBackstop" DisplayName="Health Backstop" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsHealthSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="HealthSummary" StaticName="HealthSummary" DisplayName="Health Summary" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEHUUpdatesBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="EHUUpdatesBool" StaticName="EHUUpdatesBool" DisplayName="EHU Updates Bool" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEHUUpdates = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="EHUUpdates" StaticName="EHUUpdates" DisplayName="EHU Updates" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEHUPresent = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="EHUPresent" StaticName="EHUPresent" DisplayName="EHU Present" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

###### HR

$global:FieldDefOMTReportsNationalStaffNumber = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Number" Decimals="0" Name="NationalStaffNumber" StaticName="NationalStaffNumber" DisplayName="National Staff Number" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsInternationalStaffNumber = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Number" Decimals="0" Name="InternationalStaffNumber" StaticName="InternationalStaffNumber" DisplayName="International Staff Number" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#### S and S

$global:FieldDefOMTReportsSecurityLevel = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SecurityLevel" StaticName="SecurityLevel" DisplayName="Security Level" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsIncidentSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="IncidentSummary" StaticName="IncidentSummary" DisplayName="Incident Summary" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityEvents = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SecurityEvents" StaticName="SecurityEvents" DisplayName="Security Events" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityContext = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SecurityContext" StaticName="SecurityContext" DisplayName="Security Context" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityChallenges = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SecurityChallenges" StaticName="SecurityChallenges" DisplayName="Security Challenges" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityManagement = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SecurityManagement" StaticName="SecurityManagement" DisplayName="Security Management" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#######Child safegaurding

$global:FieldDefOMTReportsStaffChildSafegaurding = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Number" Decimals="0" Name="StaffChildSafegaurding" StaticName="StaffChildSafegaurding" DisplayName="Staff Child Safegaurding" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSafegaurdingFocalPoint = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SafegaurdingFocalPoint" StaticName="SafegaurdingFocalPoint" DisplayName="Safegaurding Focal Point" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSafegaurdingRisks = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SafegaurdingRisks" StaticName="SafegaurdingRisks" DisplayName="Safegaurding Risks" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

##### Adv comms and media

$global:FieldDefOMTReportsCommsPack = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="CommsPack" StaticName="CommsPack" DisplayName="Comms Pack" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsMediaCoverage = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="MediaCoverage" StaticName="MediaCoverage" DisplayName="Media Coverage" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSpokespeople = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="Spokespeople" StaticName="Spokespeople" DisplayName="Spokespeople" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

####### Emergency Supply chain

$global:FieldDefOMTReportsPrepositionedStock = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="PrepositionedStock" StaticName="PrepositionedStock" DisplayName="Prepositioned Stock" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsForThisResponse = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="ForThisResponse" StaticName="ForThisResponse" DisplayName="Prepositioned Stock for This Response" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsPlannedProcurement = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Number" Decimals="0" Name="PlannedProcurement" StaticName="PlannedProcurement" DisplayName="Planned Procurement" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsProcurementSpend = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Number" Decimals="0" Name="ProcurementSpend" StaticName="ProcurementSpend" DisplayName="Procurement Spend" 
Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefOMTReports = New-ContentTypeDefinition -ID "0x0100TOY8ERESC5YEKCPIGZ4EEMFD7TMB6LH0" -Name "OMT Reports" -Group $CTGroup -Description "OMT Reports";

$global:ListOMTReports = New-ListDefinition -ListTitle $global:OMTReportsListTitle -ListUrl $global:OMTReportsListName -Description "OMT Reports" -Template $CustomListTemplate -ContentTypes @($global:CTDefUserProfile.Name);

#endregion 

#endregion