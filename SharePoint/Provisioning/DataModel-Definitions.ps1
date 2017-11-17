#region Authorization

$global:OMTSystemAdminGroupName = "_System Admin_";
$global:OMTApproverGroupName = "Approver";
$global:OMTEditorsGroupName = "Editors";
$global:OMTAllUsersGroupName = "_All OMT Users_";

$global:TARSecurityGroups = @{
        $global:OMTSystemAdminGroupName = @{ 
            "description" = "OMT Application System Administrator"
            "role" = "Full Control" 
            }
            $global:OMTApproverGroupName = @{ 
                "description" = "OMT Approvers"
                "role" = "Approve" 
                }
                $global:OMTEditorsGroupName = @{
                    "description" = "OMT Editors"
                    "role" = "Contribute"
                    }
        $global:OMTAllUsersGroupName = @{ 
            "description" = "OMT Application All Users"
            "role" = "Read"
            }
    }; 

#Groups must be returned in the order of their creation (ex: GSS SiteAdmin must be before GSS Approvers because they are the owners)
function Get-SecurityGroupNames
{
    Write-Output @($global:OMTSystemAdminGroupName, $global:OMTApproverGroupName, $global:OMTEditorsGroupName, $global:OMTAllUsersGroupName);
}

#endregion 

#region Lists Collection
function Get-ListNames
{
    Write-Output @($global:RegionsListTitle, $global:CountriesListTitle, $global:ResponseCodesListTitle, $global:OMTReportsListTitle, $global:OMTResponsesListTitle);
}

#endregion


#region Common

$global:FieldDefGroup = "_OMT";

$global:CTGroup = "_OMT";

$CustomListTemplate = "Custom List";



#endregion


#region Regions

$global:RegionsListTitle = "Regions";
$global:RegionsListName = "Regions";

# $global:FieldDefRegionsSecurityDirectorName = New-FieldDefinition @'
#     <Field ID="{DC36311B-C563-43C9-AA16-C1989008720B}" Type="Text" MaxLength="255" Name="TAR_SecurityDirectorName" StaticName="TAR_SecurityDirectorName" DisplayName="Security Director Name"
#     Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
#     ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;

# $global:FieldDefRegionsSecurityDirectorAccount = New-FieldDefinition @'
#     <Field ID="{9EF95FFD-407A-4C39-AD66-AA95E08A5A01}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_SecurityDirectorAccount" StaticName="TAR_SecurityDirectorAccount" DisplayName="Security Director Account"
#     Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
#     ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;

# $global:FieldDefRegionsSecurityDirectorEmail = New-FieldDefinition @'
#     <Field ID="{2D88B0C4-E45F-4008-850A-B4BED585D7D6}" Type="Text" MaxLength="255" Name="TAR_SecurityDirectorEmail" StaticName="TAR_SecurityDirectorEmail" DisplayName="Security Director Email"
#     Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
#     ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;

$global:CTDefRegions = New-ContentTypeDefinition -ID "0x0100DFA3462A212A4D6E9B058DEBF1EC7875" -Name "Regions" -Group $CTGroup -Description "OMT Regions";

$global:ListRegions = New-ListDefinition -ListTitle $global:RegionsListTitle -ListUrl $global:RegionsListName -Description "Regions for OMT" -Template $CustomListTemplate -ContentTypes @($global:CTDefRegions.Name);

#endregion

#region Countries

$global:CountriesListTitle = "Countries";
$global:CountriesListName = "Countries";

$global:FieldDefCountriesIsoCode = New-FieldDefinition @'
    <Field ID="{B51CF4B4-DBAA-4872-8FE0-9D3AD2986655}" Type="Text" MaxLength="3" Name="TAR_IsoCode" StaticName="TAR_IsoCode" DisplayName="ISO Code" 
    Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;


$global:CTDefCountries = New-ContentTypeDefinition -ID "0x01006DCCD19E51BB4150801B37729FBC9CCB" -Name "Countries" -Group $CTGroup -Description "OMT Countries";

$global:ListCountries = New-ListDefinition -ListTitle $global:CountriesListTitle -ListUrl $global:CountriesListName -Description "Countries for OMT" -Template $CustomListTemplate -ContentTypes @($global:CTDefCountries.Name);

#endregion

#region Response Codes

$global:ResponseCodesListTitle = "Response Codes";
$global:ResponseCodesListName = "ResponseCodes";

$global:FieldDefResponseCodesCode = New-FieldDefinition -FieldXml @'
<Field ID="{a5a350ae-3186-463e-82c8-00b75ed87a76}" Type="Text" MaxLength="255" Name="Code" StaticName="Code" DisplayName="Code" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefResponseCodesDescription = New-FieldDefinition -FieldXml @'
<Field ID="{86efff91-fb96-4b4b-9a63-04f39887ae5f}" Type="Text" MaxLength="255" Name="Description" StaticName="Description" DisplayName="Description" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefResponseCodesStartDate = New-FieldDefinition -FieldXml @'
<Field ID="{d9b4c1d6-f184-4a65-9c00-493bf9a34b93}" Type="DateTime" Name="StartDate" StaticName="StartDate" DisplayName="Start Date" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefResponseCodesRegion = New-FieldDefinition -FieldXml @'
<Field ID="{2bb7fbac-be0a-4387-82e5-5a43a5d81e28}" Type="Text" MaxLength="255" Name="Region" StaticName="Region" DisplayName="Region" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefResponseCodesCountry = New-FieldDefinition -FieldXml @'
<Field ID="{47ae60a7-9a97-4e42-abb7-01a2bb7fdf44}" Type="Text" MaxLength="255" Name="Country" StaticName="Country" DisplayName="Country" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileId = New-FieldDefinition -FieldXml @'
<Field ID="{2e82382f-31f6-4044-9cc6-677ea1c6e9ff}" Type="Number" Decimals="0" Name="UserId" StaticName="UserId" DisplayName="User ID" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileEmail = New-FieldDefinition -FieldXml @'
<Field ID="{13f3d91e-7790-4f42-942f-50276c784d15}" Type="Text" MaxLength="255" Name="UserEmail" StaticName="UserEmail" DisplayName="User Email" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;


$global:CTDefResponseCodes = New-ContentTypeDefinition -ID "0x0100C2DB3C6656AA48D89CA763E667C1FC48" -Name "Response Codes" -Group $CTGroup -Description "Response Codes";

$global:ListResponseCodes = New-ListDefinition -ListTitle $global:ResponseCodesListTitle -ListUrl $global:ResponseCodesListName -Description "Response Codes" -Template $CustomListTemplate -ContentTypes @($global:CTDefResponseCodes.Name);

#endregion

#region OMT Report List

$global:OMTReportsListTitle = "OMT Reports";
$global:OMTReportsListName = "OMTReports";

###### General questions

$global:FieldDefOMTReportsRegionalResponse = New-FieldDefinition -FieldXml @'
    <Field ID="{a341e8a0-95c5-4512-a2ba-27645ee377d4}" Type="Boolean" Name="RegionalResponse" StaticName="RegionalResponse" DisplayName="Regional Response" 
    Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsParentRegionalResponse = New-FieldDefinition -FieldXml @'
    <Field ID="{d0096bff-1f3f-43cc-a7f5-74f1cd4bd212}" Type="Text" MaxLength="255" Name="ParentRegionalResponse" StaticName="ParentRegionalResponse" DisplayName="Parent Regional Response" 
    Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSitrepDate = New-FieldDefinition -FieldXml @'
    <Field ID="{D7CC926E-5702-48A3-A133-5F971E78FBA7}" Type="DateTime" Name="SitrepDate" StaticName="SitrepDate" DisplayName="Sitrep Date" 
    Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsNextSitrepDate = New-FieldDefinition -FieldXml @'
<Field ID="{147fbb97-8264-485b-bdfd-8fd7e4244105}" Type="DateTime" Name="NextSitrepDate" StaticName="NextSitrepDate" DisplayName="Next Sitrep Date" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsGeneralContext = New-FieldDefinition -FieldXml @'
<Field ID="{c4043b00-0f1a-4de8-a2fe-35a39ffff505}" Type="Text" MaxLength="255" Name="GeneralContext" StaticName="GeneralContext" DisplayName="General Context" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRecentContextDevelopment = New-FieldDefinition -FieldXml @'
<Field ID="{fd42f03a-1d7b-45a5-99d2-1e35c761c861}" Type="Text" MaxLength="255" Name="RecentContextDevelopment" StaticName="RecentContextDevelopment" DisplayName="Recent Context Development" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsResponseUpdate = New-FieldDefinition -FieldXml @'
<Field ID="{b1f0815a-c44e-4e90-b46d-547b38621313}" Type="Text" MaxLength="255" Name="ResponseUpdate" StaticName="ResponseUpdate" DisplayName="Response Update" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOpsBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{0a221a2d-5ce1-476b-84e8-bd01dfcde530}" Type="Text" MaxLength="255" Name="OpsBackstop" StaticName="OpsBackstop" DisplayName="Ops Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#### Non SCI responses

$global:FieldDefOMTReportsNonSciResponses = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="NonSciResponses" StaticName="NonSciResponses" DisplayName="Non SCI Responses" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

####### Reach figures

$global:FieldDefOMTReportsAffectedPopulation = New-FieldDefinition -FieldXml @'
<Field ID="{e9bbc06d-3fdf-4f9a-a252-577d18764da2}" Type="Number" Decimals="0" Name="AffectedPopulation" StaticName="AffectedPopulation" DisplayName="Affected Population" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsStrategyTarget = New-FieldDefinition -FieldXml @'
<Field ID="{4c11753d-ec91-45a7-b10a-138e14340ced}" Type="Number" Decimals="0" Name="StrategyTarget" StaticName="StrategyTarget" DisplayName="Strategy Target" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsTotalReachSinceStart = New-FieldDefinition -FieldXml @'
<Field ID="{4ef71399-3520-46b8-873e-1492a1d81543}" Type="Number" Decimals="0" Name="TotalReachSinceStart" StaticName="TotalReachSinceStart" DisplayName="Total Reach Since Start" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsTotalReachSinceLastSitrep = New-FieldDefinition -FieldXml @'
<Field ID="{a87e840f-de9d-4e31-9f49-aec5ecab169b}" Type="Number" Decimals="0" Name="TotalReachSinceLastSitrep" StaticName="TotalReachSinceLastSitrep" DisplayName="Total Reach Since Last Sitrep" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsChildrenReachedSinceStart = New-FieldDefinition -FieldXml @'
<Field ID="{9c144ade-0057-4b8d-a097-f91a172f0a17}" Type="Number" Decimals="0" Name="ChildrenReachedSinceStart" StaticName="ChildrenReachedSinceStart" DisplayName="Children Reached Since Start" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsChildrenReachedSinceLastSitrep = New-FieldDefinition -FieldXml @'
<Field ID="{0341a32f-d256-4694-b6c1-2aa48051a2e5}" Type="Number" Decimals="0" Name="ChildrenReachedSinceLastSitrep" StaticName="ChildrenReachedSinceLastSitrep" DisplayName="Children Reached Since Last Sitrep" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

########## Income

$global:FieldDefOMTReportsResponseStrategyTarget = New-FieldDefinition -FieldXml @'
<Field ID="{f11914b3-f3bf-41f9-8973-d1933ecf7e91}" Type="Number" Decimals="0" Name="ResponseStrategyTarget" StaticName="ResponseStrategyTarget" DisplayName="Response Strategy Target" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSeedFundsTarget = New-FieldDefinition -FieldXml @'
<Field ID="{df761917-c4fa-4b64-bef3-c0fb56492293}" Type="Number" Decimals="0" Name="SeedFundsTarget" StaticName="SeedFundsTarget" DisplayName="Seed Funds Target" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSeedFundsTargetDate = New-FieldDefinition -FieldXml @'
<Field ID="{c03e44a4-b34e-4933-805f-a8b3938d7473}" Type="DateTime" Name="SeedFundsTargetDate" StaticName="SeedFundsTargetDate" DisplayName="Seed Funds Target Date" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

######### Deliverables

$global:FieldDefOMTReportsAssessmentBool = New-FieldDefinition -FieldXml @'
<Field ID="{2b5c66f8-8ffb-400b-8235-a6e22008b282}" Type="Boolean" Name="AssessmentBool" StaticName="AssessmentBool" DisplayName="Assessment Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsAssessment = New-FieldDefinition -FieldXml @'
<Field ID="{8e956619-ca49-4a90-80d2-c3476cd988c0}" Type="Text" MaxLength="255" Name="Assessment" StaticName="Assessment" DisplayName="Assessment" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOutlineBool = New-FieldDefinition -FieldXml @'
<Field ID="{b97b080e-3e47-44dc-833c-aca13f53ac22}" Type="Boolean" Name="OutlineBool" StaticName="OutlineBool" DisplayName="Outline Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOutline = New-FieldDefinition -FieldXml @'
<Field ID="{7b564c2c-5c14-4c57-9ff9-90c9e377aa45}" Type="Text" MaxLength="255" Name="Outline" StaticName="Outline" DisplayName="Outline" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsStrategyBool = New-FieldDefinition -FieldXml @'
<Field ID="{285e10bf-5e4c-4b5e-905d-7991c8aa2e99}" Type="Boolean" Name="StrategyBool" StaticName="StrategyBool" DisplayName="Strategy Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsStrategy = New-FieldDefinition -FieldXml @'
<Field ID="{401cc658-c74a-496a-9025-d8af54ca59d2}" Type="Text" MaxLength="255" Name="Strategy" StaticName="Strategy" DisplayName="Strategy" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsPlanBool = New-FieldDefinition -FieldXml @'
<Field ID="{04e68871-4e1f-4fef-a40d-78f31c4afb74}" Type="Boolean" Name="PlanBool" StaticName="PlanBool" DisplayName="Plan Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsPlan = New-FieldDefinition -FieldXml @'
<Field ID="{0045c801-8ad0-42e3-ac00-d1896570b506}" Type="Text" MaxLength="255" Name="Plan" StaticName="Plan" DisplayName="Plan" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOperationsControlReviewBool = New-FieldDefinition -FieldXml @'
<Field ID="{ede5d927-2216-4abb-b6ba-a19483d9ca25}" Type="Boolean" Name="OperationsControlReviewBool" StaticName="OperationsControlReviewBool" DisplayName="Operations Control Review Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOperationsControlReview = New-FieldDefinition -FieldXml @'
<Field ID="{e546ed78-fbf6-4e5b-8bdb-374b0eab61dd}" Type="Text" MaxLength="255" Name="OperationsControlReview" StaticName="OperationsControlReview" DisplayName="Operations Control Review" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRealTimeReviewBool = New-FieldDefinition -FieldXml @'
<Field ID="{7aae8dc7-c1cc-45c6-9096-571ed86979f0}" Type="Boolean" Name="RealTimeReviewBool" StaticName="RealTimeReviewBool" DisplayName="Real Time Review Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRealTimeReview = New-FieldDefinition -FieldXml @'
<Field ID="{ed99878b-3ce2-4638-98e6-6461b7c3c209}" Type="Text" MaxLength="255" Name="RealTimeReview" StaticName="RealTimeReview" DisplayName="Real Time Review" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRepresentationOnHCT = New-FieldDefinition -FieldXml @'
<Field ID="{390ae0c1-16f1-40e7-8ba7-ea53c698b503}" Type="Boolean" Name="RepresentationOnHCT" StaticName="RepresentationOnHCT" DisplayName="Representation On HCT" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationCluster = New-FieldDefinition -FieldXml @'
<Field ID="{f850a53a-4b18-4678-aeb3-4ec7420b9794}" Type="Boolean" Name="EducationCluster" StaticName="EducationCluster" DisplayName="Education Cluster" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsStaffingEducationCluster = New-FieldDefinition -FieldXml @'
<Field ID="{56300ab6-92e0-4df0-a323-db3d3ab39b19}" Type="Boolean" Name="StaffingEducationCluster" StaticName="StaffingEducationCluster" DisplayName="Staffing Education Cluster" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

######## Sectors

$global:FieldDefOMTReportsChildProtectionBool = New-FieldDefinition -FieldXml @'
<Field ID="{d73582e7-38ac-4e69-8f05-83445b546aa8}" Type="Boolean" Name="ChildProtectionBool" StaticName="ChildProtectionBool" DisplayName="Child Protection Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsChildProtectionBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{c9a67cc2-1639-40d1-b7d2-63d56a61122b}" Type="Text" MaxLength="255" Name="ChildProtectionBackstop" StaticName="ChildProtectionBackstop" DisplayName="Child Protection Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsChildProtectionSummary = New-FieldDefinition -FieldXml @'
<Field ID="{c3322733-d64f-4efd-b2d8-39e5d669221a}" Type="Text" MaxLength="255" Name="ChildProtectionSummary" StaticName="ChildProtectionSummary" DisplayName="Child Protection Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationBool = New-FieldDefinition -FieldXml @'
<Field ID="{420d4894-d5f2-4e5d-b0ee-56194660f2d9}" Type="Boolean" Name="EducationBool" StaticName="EducationBool" DisplayName="Education Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{9601b433-f14e-40bf-8cf5-23fb06da38f9}" Type="Text" MaxLength="255" Name="EducationBackstop" StaticName="EducationBackstop" DisplayName="Education Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationSummary = New-FieldDefinition -FieldXml @'
<Field ID="{857f978b-7c99-4129-913f-91e82ac54cff}" Type="Text" MaxLength="255" Name="EducationSummary" StaticName="EducationSummary" DisplayName="Education Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsFSLBool = New-FieldDefinition -FieldXml @'
<Field ID="{595fc6f8-2173-4e6b-bc72-9fa8edb3ea5d}" Type="Boolean" Name="FSLBool" StaticName="FSLBool" DisplayName="FSLBool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsFSLBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{8e746a10-2ffb-40dd-9ffb-9ac7ec552058}" Type="Text" MaxLength="255" Name="FSLBackstop" StaticName="FSLBackstop" DisplayName="FSL Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsFSLSummary = New-FieldDefinition -FieldXml @'
<Field ID="{15c04826-6588-405c-b2a5-a2c922fbac78}" Type="Text" MaxLength="255" Name="FSLSummary" StaticName="FSLSummary" DisplayName="FSL Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsWASHBool = New-FieldDefinition -FieldXml @'
<Field ID="{2309ab06-1f7e-4232-8fb7-09bf4619f9ba}" Type="Boolean" Name="WASHBool" StaticName="WASHBool" DisplayName="WASH Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsWASHBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{4ac9067f-ec6b-4456-b64e-9d17ef436d7f}" Type="Text" MaxLength="255" Name="WASHBackstop" StaticName="WASHBackstop" DisplayName="WASH Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsWASHSummary = New-FieldDefinition -FieldXml @'
<Field ID="{b6a35264-5bab-42d2-ad29-f676e077525c}" Type="Text" MaxLength="255" Name="WASHSummary" StaticName="WASHSummary" DisplayName="WASH Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsShelterBool = New-FieldDefinition -FieldXml @'
<Field ID="{ee09f2d7-e25a-4a79-ae7b-6f80f0f263e4}" Type="Boolean" Name="ShelterBool" StaticName="ShelterBool" DisplayName="Shelter Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsShelterBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{afa0740e-4d04-4aa7-95fb-b1474882681c}" Type="Text" MaxLength="255" Name="ShelterBackstop" StaticName="ShelterBackstop" DisplayName="Shelter Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsShelterSummary = New-FieldDefinition -FieldXml @'
<Field ID="{b840cd52-087f-4d75-9087-93ef3f902f58}" Type="Text" MaxLength="255" Name="ShelterSummary" StaticName="ShelterSummary" DisplayName="Shelter Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsHealthBool = New-FieldDefinition -FieldXml @'
<Field ID="{df695d46-0a93-4183-b113-4e738f84470c}" Type="Boolean" Name="HealthBool" StaticName="HealthBool" DisplayName="Health Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsHealthBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{de48a28f-7efb-4646-86a0-f823a983758b}" Type="Text" MaxLength="255" Name="HealthBackstop" StaticName="HealthBackstop" DisplayName="Health Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsHealthSummary = New-FieldDefinition -FieldXml @'
<Field ID="{d4c41cc1-29c4-4c99-8b70-c14b81b945de}" Type="Text" MaxLength="255" Name="HealthSummary" StaticName="HealthSummary" DisplayName="Health Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEHUUpdatesBool = New-FieldDefinition -FieldXml @'
<Field ID="{f3626271-8e78-4511-bf08-5a86e38bce5d}" Type="Boolean" Name="EHUUpdatesBool" StaticName="EHUUpdatesBool" DisplayName="EHU Updates Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEHUUpdates = New-FieldDefinition -FieldXml @'
<Field ID="{4b8e21f7-c03e-4d20-a6dd-3f120c878844}" Type="Text" MaxLength="255" Name="EHUUpdates" StaticName="EHUUpdates" DisplayName="EHU Updates" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEHUPresent = New-FieldDefinition -FieldXml @'
<Field ID="{d9d0c726-38e7-4b44-91d9-0e34ba8f86b2}" Type="Boolean" Name="EHUPresent" StaticName="EHUPresent" DisplayName="EHU Present" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

###### HR

$global:FieldDefOMTReportsNationalStaffNumber = New-FieldDefinition -FieldXml @'
<Field ID="{31ab478f-4606-4ec8-b3c6-6da5c62a5489}" Type="Number" Decimals="0" Name="NationalStaffNumber" StaticName="NationalStaffNumber" DisplayName="National Staff Number" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsInternationalStaffNumber = New-FieldDefinition -FieldXml @'
<Field ID="{e3508f0f-4f38-45d5-b676-e69831c9b9e6}" Type="Number" Decimals="0" Name="InternationalStaffNumber" StaticName="InternationalStaffNumber" DisplayName="International Staff Number" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#### S and S

$global:FieldDefOMTReportsSecurityLevel = New-FieldDefinition -FieldXml @'
<Field ID="{8fce5c51-6200-428f-86bc-ee76268de67b}" Type="Text" MaxLength="255" Name="SecurityLevel" StaticName="SecurityLevel" DisplayName="Security Level" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsIncidentSummary = New-FieldDefinition -FieldXml @'
<Field ID="{4df06f0c-4c12-45ec-bfa6-4b75caa2870b}" Type="Text" MaxLength="255" Name="IncidentSummary" StaticName="IncidentSummary" DisplayName="Incident Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityEvents = New-FieldDefinition -FieldXml @'
<Field ID="{d1666b63-3c36-4a03-8b52-e106b0188278}" Type="Text" MaxLength="255" Name="SecurityEvents" StaticName="SecurityEvents" DisplayName="Security Events" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityContext = New-FieldDefinition -FieldXml @'
<Field ID="{dfb22f7f-1721-4166-9b37-607d8dedea5d}" Type="Text" MaxLength="255" Name="SecurityContext" StaticName="SecurityContext" DisplayName="Security Context" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityChallenges = New-FieldDefinition -FieldXml @'
<Field ID="{ed3c44a0-9827-411b-9f43-f7b7135d3241}" Type="Text" MaxLength="255" Name="SecurityChallenges" StaticName="SecurityChallenges" DisplayName="Security Challenges" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityManagement = New-FieldDefinition -FieldXml @'
<Field ID="{01fb4146-2e2a-4e09-8f5d-7ca20e47c047}" Type="Text" MaxLength="255" Name="SecurityManagement" StaticName="SecurityManagement" DisplayName="Security Management" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#######Child safegaurding

$global:FieldDefOMTReportsStaffChildSafegaurding = New-FieldDefinition -FieldXml @'
<Field ID="{50560281-9e50-4820-9420-432e0bf535eb}" Type="Number" Decimals="0" Name="StaffChildSafegaurding" StaticName="StaffChildSafegaurding" DisplayName="Staff Child Safegaurding" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSafegaurdingFocalPoint = New-FieldDefinition -FieldXml @'
<Field ID="{f8e55de2-80d3-4653-ad24-fd8fadfd6365}" Type="Text" MaxLength="255" Name="SafegaurdingFocalPoint" StaticName="SafegaurdingFocalPoint" DisplayName="Safegaurding Focal Point" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSafegaurdingRisks = New-FieldDefinition -FieldXml @'
<Field ID="{d37de8e6-bd1b-4905-89e6-2a376b03ef56}" Type="Text" MaxLength="255" Name="SafegaurdingRisks" StaticName="SafegaurdingRisks" DisplayName="Safegaurding Risks" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

##### Adv comms and media

$global:FieldDefOMTReportsCommsPack = New-FieldDefinition -FieldXml @'
<Field ID="{6d4850d3-6da6-48b3-bfbd-853473270f0d}" Type="Text" MaxLength="255" Name="CommsPack" StaticName="CommsPack" DisplayName="Comms Pack" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsMediaCoverage = New-FieldDefinition -FieldXml @'
<Field ID="{04d1b173-dc44-4d44-aa51-d86a1cb2ea79}" Type="Text" MaxLength="255" Name="MediaCoverage" StaticName="MediaCoverage" DisplayName="Media Coverage" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSpokespeople = New-FieldDefinition -FieldXml @'
<Field ID="{8450ac34-ce81-4754-9220-5e1a4c831d28}" Type="Text" MaxLength="255" Name="Spokespeople" StaticName="Spokespeople" DisplayName="Spokespeople" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

####### Emergency Supply chain

$global:FieldDefOMTReportsPrepositionedStock = New-FieldDefinition -FieldXml @'
<Field ID="{ee55f860-4d3d-4b1d-9a6a-1209e278c047}" Type="Boolean" Name="PrepositionedStock" StaticName="PrepositionedStock" DisplayName="Prepositioned Stock" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsForThisResponse = New-FieldDefinition -FieldXml @'
<Field ID="{eb8157e1-dc6d-4912-9ecf-2e3bbd5e798b}" Type="Boolean" Name="ForThisResponse" StaticName="ForThisResponse" DisplayName="Prepositioned Stock for This Response" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsPlannedProcurement = New-FieldDefinition -FieldXml @'
<Field ID="{9ecf6c99-fa9a-4904-a514-dba6b488fbc9}" Type="Number" Decimals="0" Name="PlannedProcurement" StaticName="PlannedProcurement" DisplayName="Planned Procurement" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsProcurementSpend = New-FieldDefinition -FieldXml @'
<Field ID="{ccb28465-0d2b-469d-9d5f-3a0fc7aa67e0}" Type="Number" Decimals="0" Name="ProcurementSpend" StaticName="ProcurementSpend" DisplayName="Procurement Spend" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

# $global:FieldDefOMTReportsId = New-FieldDefinition -FieldXml @'
# <Field ID="{6fe266c5-8ab3-4a82-8bab-784180135f50}" Type="Number" Decimals="0" Name="UserId" StaticName="UserId" DisplayName="User ID" 
#     Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
#     ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;

# $global:FieldDefOMTReportsEmail = New-FieldDefinition -FieldXml @'
#     <Field ID="{b6ae2134-be39-4282-8a50-00690b056e25}" Type="Text" MaxLength="255" Name="UserEmail" StaticName="UserEmail" DisplayName="User Email" 
#     Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
#     ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;

$global:CTDefOMTReports = New-ContentTypeDefinition -ID "0x0100C2DB3C6656AA48D89CA763E667C1FC48" -Name "OMT Reports" -Group $CTGroup -Description "OMT Reports";

$global:ListOMTReports = New-ListDefinition -ListTitle $global:OMTReportsListTitle -ListUrl $global:OMTReportsListName -Description "OMT Reports" -Template $CustomListTemplate -ContentTypes @($global:CTDefOMTReports.Name);

#endregion 


#endregion



#region OMT Responses

$global:OMTResponsesListTitle = "OMT Responses";
$global:OMTResponsesListName = "OMTResponses";

$global:FieldDefOMTResponsesProcurementSpend = New-FieldDefinition -FieldXml @'
<Field ID="{7601c074-df56-45bf-ae2a-d11d2ebfeef0}" Type="Number" Decimals="0" Name="ProcurementSpend" StaticName="ProcurementSpend" DisplayName="Procurement Spend" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefOMTResponses = New-ContentTypeDefinition -ID "0x0100750DED44DE8C448F9F59414BCE29DFBB" -Name "OMT Responses" -Group $CTGroup -Description "OMT Responses";

$global:ListOMTResponses = New-ListDefinition -ListTitle $global:OMTResponsesListTitle -ListUrl $global:OMTResponsesListName -Description "OMT Responses" -Template $CustomListTemplate -ContentTypes @($global:CTDefOMTResponses.Name);

#endregion

