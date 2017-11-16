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
    Write-Output @($global:RegionsListTitle, $global:CountriesListTitle, $global:ResponseCodesListTitle, $global:OMTReportsListTitle);
}

#endregion


#region Regions

$global:RegionsListTitle = "Regions";
$global:RegionsListName = "Regions";

$global:FieldDefRegionsSecurityDirectorName = New-FieldDefinition @'
    <Field ID="{DC36311B-C563-43C9-AA16-C1989008720B}" Type="Text" MaxLength="255" Name="TAR_SecurityDirectorName" StaticName="TAR_SecurityDirectorName" DisplayName="Security Director Name"
    Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefRegionsSecurityDirectorAccount = New-FieldDefinition @'
    <Field ID="{9EF95FFD-407A-4C39-AD66-AA95E08A5A01}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_SecurityDirectorAccount" StaticName="TAR_SecurityDirectorAccount" DisplayName="Security Director Account"
    Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefRegionsSecurityDirectorEmail = New-FieldDefinition @'
    <Field ID="{2D88B0C4-E45F-4008-850A-B4BED585D7D6}" Type="Text" MaxLength="255" Name="TAR_SecurityDirectorEmail" StaticName="TAR_SecurityDirectorEmail" DisplayName="Security Director Email"
    Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefRegions = New-ContentTypeDefinition -ID "0x0100DFA3462A212A4D6E9B058DEBF1EC7875" -Name "Regions" -Group $CTGroup -Description "OMT Regions";

$global:ListRegions = New-ListDefinition -ListTitle $global:RegionsListTitle -ListUrl $global:RegionsListName -Description "Regions for TAR" -Template $CustomListTemplate -ContentTypes @($global:CTDefRegions.Name);

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
<Field ID="{d402c6bf-b0da-4ec7-a1db-9d10c8a0afba}" Type="Text" MaxLength="255" Name="Description" StaticName="Description" DisplayName="Description" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefResponseCodesStartDate = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="DateTime" Name="StartDate" StaticName="StartDate" DisplayName="Start Date" 
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
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileEmail = New-FieldDefinition -FieldXml @'
<Field ID="{13f3d91e-7790-4f42-942f-50276c784d15}" Type="Text" MaxLength="255" Name="UserEmail" StaticName="UserEmail" DisplayName="User Email" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;


$global:CTDefResponseCodes = New-ContentTypeDefinition -ID "0x0100C2DB3C6656AA48D89CA763E667C1FC37" -Name "Response Codes" -Group $CTGroup -Description "Response Codes";

$global:ListResponseCodes = New-ListDefinition -ListTitle $global:ResponseCodesListTitle -ListUrl $global:ResponseCodesListName -Description "Response Codes" -Template $CustomListTemplate -ContentTypes @($global:CTDefRegions.Name);

#endregion

#region OMT Report List

$global:OMTReportsListName = "OMTReports";
$global:OMTReportsListTitle = "OMT Reports";

$global:FieldDefOMTReportsId = New-FieldDefinition -FieldXml @'
<Field ID="{6fe266c5-8ab3-4a82-8bab-784180135f50}" Type="Number" Decimals="0" Name="UserId" StaticName="UserId" DisplayName="User ID" 
    Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEmail = New-FieldDefinition -FieldXml @'
    <Field ID="{b6ae2134-be39-4282-8a50-00690b056e25}" Type="Text" MaxLength="255" Name="UserEmail" StaticName="UserEmail" DisplayName="User Email" 
    Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

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
<Field ID="{}" Type="Text" MaxLength="255" Name="Strategy" StaticName="Strategy" DisplayName="Strategy" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsPlanBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="PlanBool" StaticName="PlanBool" DisplayName="Plan Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsPlan = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="Plan" StaticName="Plan" DisplayName="Plan" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOperationsControlReviewBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="OperationsControlReviewBool" StaticName="OperationsControlReviewBool" DisplayName="Operations Control Review Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsOperationsControlReview = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="OperationsControlReview" StaticName="OperationsControlReview" DisplayName="Operations Control Review" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRealTimeReviewBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="RealTimeReviewBool" StaticName="RealTimeReviewBool" DisplayName="Real Time Review Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRealTimeReview = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="RealTimeReview" StaticName="RealTimeReview" DisplayName="Real Time Review" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsRepresentationOnHCT = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="RepresentationOnHCT" StaticName="RepresentationOnHCT" DisplayName="Representation On HCT" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationCluster = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="EducationCluster" StaticName="EducationCluster" DisplayName="Education Cluster" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsStaffingEducationCluster = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="StaffingEducationCluster" StaticName="StaffingEducationCluster" DisplayName="Staffing Education Cluster" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

######## Sectors

$global:FieldDefOMTReportsChildProtectionBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="ChildProtectionBool" StaticName="ChildProtectionBool" DisplayName="Child Protection Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsChildProtectionBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="ChildProtectionBackstop" StaticName="ChildProtectionBackstop" DisplayName="Child Protection Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsChildProtectionSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="ChildProtectionSummary" StaticName="ChildProtectionSummary" DisplayName="Child Protection Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="EducationBool" StaticName="EducationBool" DisplayName="Education Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="EducationBackstop" StaticName="EducationBackstop" DisplayName="Education Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEducationSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="EducationSummary" StaticName="EducationSummary" DisplayName="Education Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsFSLBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="FSLBool" StaticName="FSLBool" DisplayName="FSLBool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsFSLBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="FSLBackstop" StaticName="FSLBackstop" DisplayName="FSL Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsFSLSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="FSLSummary" StaticName="FSLSummary" DisplayName="FSL Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsWASHBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="WASHBool" StaticName="WASHBool" DisplayName="WASH Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsWASHBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="WASHBackstop" StaticName="WASHBackstop" DisplayName="WASH Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsWASHSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="WASHSummary" StaticName="WASHSummary" DisplayName="WASH Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsShelterBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="ShelterBool" StaticName="ShelterBool" DisplayName="Shelter Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsShelterBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="ShelterBackstop" StaticName="ShelterBackstop" DisplayName="Shelter Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsShelterSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="ShelterSummary" StaticName="ShelterSummary" DisplayName="Shelter Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsHealthBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="HealthBool" StaticName="HealthBool" DisplayName="Health Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsHealthBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="HealthBackstop" StaticName="HealthBackstop" DisplayName="Health Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsHealthSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="HealthSummary" StaticName="HealthSummary" DisplayName="Health Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEHUUpdatesBool = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="EHUUpdatesBool" StaticName="EHUUpdatesBool" DisplayName="EHU Updates Bool" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEHUUpdates = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="EHUUpdates" StaticName="EHUUpdates" DisplayName="EHU Updates" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsEHUPresent = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="EHUPresent" StaticName="EHUPresent" DisplayName="EHU Present" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

###### HR

$global:FieldDefOMTReportsNationalStaffNumber = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Number" Decimals="0" Name="NationalStaffNumber" StaticName="NationalStaffNumber" DisplayName="National Staff Number" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsInternationalStaffNumber = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Number" Decimals="0" Name="InternationalStaffNumber" StaticName="InternationalStaffNumber" DisplayName="International Staff Number" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#### S and S

$global:FieldDefOMTReportsSecurityLevel = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SecurityLevel" StaticName="SecurityLevel" DisplayName="Security Level" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsIncidentSummary = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="IncidentSummary" StaticName="IncidentSummary" DisplayName="Incident Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityEvents = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SecurityEvents" StaticName="SecurityEvents" DisplayName="Security Events" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityContext = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SecurityContext" StaticName="SecurityContext" DisplayName="Security Context" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityChallenges = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SecurityChallenges" StaticName="SecurityChallenges" DisplayName="Security Challenges" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSecurityManagement = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SecurityManagement" StaticName="SecurityManagement" DisplayName="Security Management" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#######Child safegaurding

$global:FieldDefOMTReportsStaffChildSafegaurding = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Number" Decimals="0" Name="StaffChildSafegaurding" StaticName="StaffChildSafegaurding" DisplayName="Staff Child Safegaurding" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSafegaurdingFocalPoint = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SafegaurdingFocalPoint" StaticName="SafegaurdingFocalPoint" DisplayName="Safegaurding Focal Point" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSafegaurdingRisks = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="SafegaurdingRisks" StaticName="SafegaurdingRisks" DisplayName="Safegaurding Risks" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

##### Adv comms and media

$global:FieldDefOMTReportsCommsPack = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="CommsPack" StaticName="CommsPack" DisplayName="Comms Pack" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsMediaCoverage = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="MediaCoverage" StaticName="MediaCoverage" DisplayName="Media Coverage" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsSpokespeople = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Text" MaxLength="255" Name="Spokespeople" StaticName="Spokespeople" DisplayName="Spokespeople" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

####### Emergency Supply chain

$global:FieldDefOMTReportsPrepositionedStock = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="PrepositionedStock" StaticName="PrepositionedStock" DisplayName="Prepositioned Stock" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsForThisResponse = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Boolean" Name="ForThisResponse" StaticName="ForThisResponse" DisplayName="Prepositioned Stock for This Response" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsPlannedProcurement = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Number" Decimals="0" Name="PlannedProcurement" StaticName="PlannedProcurement" DisplayName="Planned Procurement" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOMTReportsProcurementSpend = New-FieldDefinition -FieldXml @'
<Field ID="{}" Type="Number" Decimals="0" Name="ProcurementSpend" StaticName="ProcurementSpend" DisplayName="Procurement Spend" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefOMTReports = New-ContentTypeDefinition -ID "0x0100TOY8ERESC5YEKCPIGZ4EEMFD7TMB6LH0" -Name "OMT Reports" -Group $CTGroup -Description "OMT Reports";

$global:ListOMTReports = New-ListDefinition -ListTitle $global:OMTReportsListTitle -ListUrl $global:OMTReportsListName -Description "OMT Reports" -Template $CustomListTemplate -ContentTypes @($global:CTDefUserProfile.Name);

#endregion 

#endregion