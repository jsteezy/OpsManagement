#region Authorization

$global:OMTSystemAdminGroupName = "_System Admin_";
$global:OMTApproverGroupName = "Approver";
$global:OMTEditorsGroupName = "Editors";
$global:OMTAllUsersGroupName = "_All OMT Users_";

$global:OMTSecurityGroups = @{
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
            "role" = "Read"`
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

$global:FieldDefRegionsName = New-FieldDefinition @'
    <Field ID="{DC36311B-C563-43C9-AA16-C198900873SB}" Type="Text" MaxLength="255" Name="Name" StaticName="Name" DisplayName="Name"
    Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefRegions = New-ContentTypeDefinition -ID "0x0100DFA3462A212A4D6E9B058DEBF1EC7875" -Name "Regions" -Group $CTGroup -Description "OMT Regions";

$global:ListRegions = New-ListDefinition -ListTitle $global:RegionsListTitle -ListUrl $global:RegionsListName -Description "Regions for OMT" -Template $CustomListTemplate -ContentTypes @($global:CTDefRegions.Name);

#endregion

#region Countries

$global:CountriesListTitle = "Countries";
$global:CountriesListName = "Countries";

$global:FieldDefCountriesIsoCode = New-FieldDefinition @'
    <Field ID="{B51CF4B4-DBAA-4872-8FE0-9D3AD2986655}" Type="Text" MaxLength="3" Name="IsoCode" StaticName="IsoCode" DisplayName="ISO Code" 
    Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;


$global:CTDefCountries = New-ContentTypeDefinition -ID "0x01006DCCD19E51BB4150801B37729FBC9CCB" -Name "Countries" -Group $CTGroup -Description "OMT Countries";

$global:ListCountries = New-ListDefinition -ListTitle $global:CountriesListTitle -ListUrl $global:CountriesListName -Description "Countries for OMT" -Template $CustomListTemplate -ContentTypes @($global:CTDefCountries.Name);

#endregion

#region Reports

$global:ReportsListTitle = "Reports";
$global:ReportsListName = "Reports";

$global:FieldDefReportsStatus = New-FieldDefinition -FieldXml @'
<Field ID="{8fce5c51-6200-428f-82sc-ee76268de67b}" Type="Text" MaxLength="25" Name="Status" StaticName="Status" DisplayName="Status" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefResponseId = New-FieldDefinition -FieldXml @'
<Field ID="{B51CF4B4-DBAA-4872-8FE0-9D3AD2986622}" Type="Number" Decimals="0" Name="ResponseId" StaticName="ResponseId" DisplayName="Response Id" 
Group="_OMT" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

###### General questions

# $global:FieldDefReportsRegionalResponse = New-FieldDefinition -FieldXml @'
# <Field ID="{a341e8a0-95c5-4512-a2ba-27645ee377d4}" Type="Boolean" Name="RegionalResponse" StaticName="RegionalResponse" DisplayName="Regional Response" 
# Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
# ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;

# $global:FieldDefReportsParentRegionalResponse = New-FieldDefinition -FieldXml @'
# <Field ID="{d0096bff-1f3f-43cc-a7f5-74f1cd4bd212}" Type="Text" MaxLength="200" Name="ParentRegionalResponse" StaticName="ParentRegionalResponse" DisplayName="Parent Regional Response" 
# Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
# ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;

$global:FieldDefReportsSitrepDate = New-FieldDefinition -FieldXml @'
<Field ID="{D7CC926E-5702-48A3-A133-5F971E78FBA7}" Type="DateTime" Name="SitrepDate" StaticName="SitrepDate" DisplayName="Sitrep Date" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsNextSitrepDate = New-FieldDefinition -FieldXml @'
<Field ID="{147fbb97-8264-485b-bdfd-8fd7e4244105}" Type="DateTime" Name="NextSitrepDate" StaticName="NextSitrepDate" DisplayName="Next Sitrep Date" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

# $global:FieldDefReportsRecentContextDevelopment = New-FieldDefinition -FieldXml @'
# <Field ID="{fd42f03a-1d7b-45a5-99d2-1e35c761c861}" Type="Text" MaxLength="255" Name="RecentContextDevelopment" StaticName="RecentContextDevelopment" DisplayName="Recent Context Development" 
# Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
# ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;

$global:FieldDefReportsOpsBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{0a221a2d-5ce1-476b-84e8-bd01dfcde530}" Type="Text" MaxLength="255" Name="OpsBackstop" StaticName="OpsBackstop" DisplayName="Ops Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;


##new

$global:FieldDefReportsResponseStatus = New-FieldDefinition -FieldXml @'
<Field ID="{1ee92ed9-380d-4d01-bcf7-b98dd57fe759}" Type="Text" MaxLength="255" Name="ResponseStatus" StaticName="ResponseStatus" DisplayName="Response Status" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsCategory = New-FieldDefinition -FieldXml @'
<Field ID="{beb9f7e0-887a-41b4-a28c-f17c94da7334}" Type="Number" Decimals="0" Name="Category" StaticName="Category" DisplayName="Category" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsPhase = New-FieldDefinition -FieldXml @'
<Field ID="{09b3fe3e-609e-4e2b-8f11-04f214123347}" Type="Text" MaxLength="255" Name="Phase" StaticName="Phase" DisplayName="Phase" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsSCIImplemented = New-FieldDefinition -FieldXml @'
<Field ID="{96a08aec-4e48-4a75-8df2-8a75e44782c5}" Type="Boolean" Name="SCIImplemented" StaticName="SCIImplemented" DisplayName="SCI Implemented" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsSitrepNumber = New-FieldDefinition -FieldXml @'
<Field ID="{5f829b01-25db-4da2-8f64-966c39f6610d}" Type="Number" Decimals="0" Name="SitrepNumber" StaticName="SitrepNumber" DisplayName="Sitrep Number" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsGeneralContextInternal = New-FieldDefinition -FieldXml @'
<Field ID="{42fe4bc1-e68e-4364-b271-e64018c0298d}" Type="Text" MaxLength="1500" Name="GeneralContextInternal" StaticName="GeneralContextInternal" DisplayName="General Context Internal" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsGeneralContextExternal = New-FieldDefinition -FieldXml @'
<Field ID="{adb6e9c4-28c3-484c-934d-c42d7cf4e6a3}" Type="Text" MaxLength="1200" Name="GeneralContextExternal" StaticName="GeneralContextExternal" DisplayName="General Context External" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsResponseUpdateInternal = New-FieldDefinition -FieldXml @'
<Field ID="{16223800-3900-43de-951f-3e0981fc96bc}" Type="Text" MaxLength="750" Name="ResponseUpdateInternal" StaticName="ResponseUpdateInternal" DisplayName="Response Update Internal" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsResponseUpdateExternal = New-FieldDefinition -FieldXml @'
<Field ID="{6c6b3f17-a6f9-421f-b621-821819cca378}" Type="Text" MaxLength="750" Name="ResponseUpdateExternal" StaticName="ResponseUpdateExternal" DisplayName="Response Update External" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsChallengesInternal = New-FieldDefinition -FieldXml @'
<Field ID="{db473747-226d-455b-b9e0-9db487ec92ac}" Type="Text" MaxLength="1500" Name="ChallengesInternal" StaticName="ChallengesInternal" DisplayName="Challenges Internal" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;


#### Non SCI responses

# $global:FieldDefReportsNonSciResponses = New-FieldDefinition -FieldXml @'
# <Field ID="{a83a4e96-fff3-44f9-a3cb-cec1d6037d7d}" Type="Boolean" Name="NonSciResponses" StaticName="NonSciResponses" DisplayName="Non SCI Responses" 
# Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
# ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;

####### Reach figures

$global:FieldDefReportsAffectedPopulation = New-FieldDefinition -FieldXml @'
<Field ID="{e9bbc06d-3fdf-4f9a-a252-577d18764da2}" Type="Number" Decimals="0" Name="AffectedPopulation" StaticName="AffectedPopulation" DisplayName="Affected Population" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsStrategyTarget = New-FieldDefinition -FieldXml @'
<Field ID="{4c11753d-ec91-45a7-b10a-138e14340ced}" Type="Number" Decimals="0" Name="StrategyTarget" StaticName="StrategyTarget" DisplayName="Strategy Target" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsTotalReachSinceStart = New-FieldDefinition -FieldXml @'
<Field ID="{4ef71399-3520-46b8-873e-1492a1d81543}" Type="Number" Decimals="0" Name="TotalReachSinceStart" StaticName="TotalReachSinceStart" DisplayName="Total Reach Since Start" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsTotalReachSinceLastSitrep = New-FieldDefinition -FieldXml @'
<Field ID="{a87e840f-de9d-4e31-9f49-aec5ecab169b}" Type="Number" Decimals="0" Name="TotalReachSinceLastSitrep" StaticName="TotalReachSinceLastSitrep" DisplayName="Total Reach Since Last Sitrep" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsChildrenReachedSinceStart = New-FieldDefinition -FieldXml @'
<Field ID="{9c144ade-0057-4b8d-a097-f91a172f0a17}" Type="Number" Decimals="0" Name="ChildrenReachedSinceStart" StaticName="ChildrenReachedSinceStart" DisplayName="Children Reached Since Start" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsChildrenReachedSinceLastSitrep = New-FieldDefinition -FieldXml @'
<Field ID="{0341a32f-d256-4694-b6c1-2aa48051a2e5}" Type="Number" Decimals="0" Name="ChildrenReachedSinceLastSitrep" StaticName="ChildrenReachedSinceLastSitrep" DisplayName="Children Reached Since Last Sitrep" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsStrategyTargetChildren = New-FieldDefinition -FieldXml @'
<Field ID="{a5bbd2bb-7186-4caa-9cb5-6071cd36e924}" Type="Number" Decimals="0" Name="StrategyTargetChildren" StaticName="StrategyTargetChildren" DisplayName="Strategy Target Children" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

########## Income

$global:FieldDefReportsResponseStrategyTarget = New-FieldDefinition -FieldXml @'
<Field ID="{f11914b3-f3bf-41f9-8973-d1933ecf7e91}" Type="Number" Decimals="0" Name="ResponseStrategyTarget" StaticName="ResponseStrategyTarget" DisplayName="Response Strategy Target" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsSeedFundsTarget = New-FieldDefinition -FieldXml @'
<Field ID="{df761917-c4fa-4b64-bef3-c0fb56492293}" Type="Number" Decimals="0" Name="SeedFundsTarget" StaticName="SeedFundsTarget" DisplayName="Seed Funds Target" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsSeedFundsTargetDate = New-FieldDefinition -FieldXml @'
<Field ID="{c03e44a4-b34e-4933-805f-a8b3938d7473}" Type="DateTime" Name="SeedFundsTargetDate" StaticName="SeedFundsTargetDate" DisplayName="Seed Funds Target Date" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsCrisisModifiers = New-FieldDefinition -FieldXml @'
<Field ID="{2a242300-fa66-4aff-941a-b60ba74c579d}" Type="Number" Decimals="0" Name="CrisisModifiers" StaticName="CrisisModifiers" DisplayName="Crisis Modifiers" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

######### Deliverables



$global:FieldDefReportsAssessmentBool = New-FieldDefinition -FieldXml @'
<Field ID="{8516b83e-ec7a-4fed-b93b-09b666c4149c}" Type="Boolean" Name="AssessmentBool" StaticName="AssessmentBool" DisplayName="Assessment" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsOutlineBool = New-FieldDefinition -FieldXml @'
<Field ID="{2ef02805-2c3c-447c-a671-85232171926d}" Type="Boolean" Name="OutlineBool" StaticName="OutlineBool" DisplayName="Outline" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsStrategyBool = New-FieldDefinition -FieldXml @'
<Field ID="{15738dd8-9fb0-4e6b-8b09-e027a67cfe7c}" Type="Boolean" Name="StrategyBool" StaticName="StrategyBool" DisplayName="Strategy" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsPlanBool = New-FieldDefinition -FieldXml @'
<Field ID="{e32bb9d2-df92-46a2-825d-1c81fd098f62}" Type="Boolean" Name="PlanBool" StaticName="PlanBool" DisplayName="Plan" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsOperationsControlReviewBool = New-FieldDefinition -FieldXml @'
<Field ID="{4527d034-d944-4b3e-80ca-1ac0f93c58b0}" Type="Boolean" Name="OperationsControlReviewBool" StaticName="OperationsControlReviewBool" DisplayName="Operations Control Review" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsRealTimeReviewBool = New-FieldDefinition -FieldXml @'
<Field ID="{9ac93ca0-1977-42ec-b173-e58a8d8e8462}" Type="Boolean" Name="RealTimeReview" StaticName="RealTimeReview" DisplayName="Real Time Review" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsRepresentationOnHCTBool = New-FieldDefinition -FieldXml @'
<Field ID="{c8656946-b5fc-4b32-ba4f-ebf434da9c12}" Type="Boolean" Name="RepresentationOnHCTBool" StaticName="RepresentationOnHCTBool" DisplayName="Representation On HCT" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsEducationClusterBool = New-FieldDefinition -FieldXml @'
<Field ID="{d191ff67-9957-4d1f-b2e9-ffc52f059dc0}" Type="Boolean" Name="EducationCluster" StaticName="EducationClusterBool" DisplayName="Education Cluster" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsStaffingEducationClusterBool = New-FieldDefinition -FieldXml @'
<Field ID="{bf667c73-256a-4309-8b7d-8a9bb8727ee5}" Type="Boolean" Name="StaffingEducationClusterBool" StaticName="StaffingEducationClusterBool" DisplayName="Staffing Education Cluster" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

######## Sectors

$global:FieldDefReportsChildProtectionBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{c9a67cc2-1639-40d1-b7d2-63d56a61122b}" Type="Text" MaxLength="300" Name="ChildProtectionBackstop" StaticName="ChildProtectionBackstop" DisplayName="Child Protection Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsChildProtectionSummary = New-FieldDefinition -FieldXml @'
<Field ID="{c3322733-d64f-4efd-b2d8-39e5d669221a}" Type="Text" MaxLength="300" Name="ChildProtectionSummary" StaticName="ChildProtectionSummary" DisplayName="Child Protection Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsEducationBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{9601b433-f14e-40bf-8cf5-23fb06da38f9}" Type="Text" MaxLength="300" Name="EducationBackstop" StaticName="EducationBackstop" DisplayName="Education Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsEducationSummary = New-FieldDefinition -FieldXml @'
<Field ID="{857f978b-7c99-4129-913f-91e82ac54cff}" Type="Text" MaxLength="300" Name="EducationSummary" StaticName="EducationSummary" DisplayName="Education Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsFSLBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{8e746a10-2ffb-40dd-9ffb-9ac7ec552058}" Type="Text" MaxLength="300" Name="FSLBackstop" StaticName="FSLBackstop" DisplayName="FSL Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsFSLSummary = New-FieldDefinition -FieldXml @'
<Field ID="{15c04826-6588-405c-b2a5-a2c922fbac78}" Type="Text" MaxLength="300" Name="FSLSummary" StaticName="FSLSummary" DisplayName="FSL Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsWASHBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{4ac9067f-ec6b-4456-b64e-9d17ef436d7f}" Type="Text" MaxLength="300" Name="WASHBackstop" StaticName="WASHBackstop" DisplayName="WASH Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsWASHSummary = New-FieldDefinition -FieldXml @'
<Field ID="{b6a35264-5bab-42d2-ad29-f676e077525c}" Type="Text" MaxLength="300" Name="WASHSummary" StaticName="WASHSummary" DisplayName="WASH Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsShelterBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{afa0740e-4d04-4aa7-95fb-b1474882681c}" Type="Text" MaxLength="300" Name="ShelterBackstop" StaticName="ShelterBackstop" DisplayName="Shelter Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsShelterSummary = New-FieldDefinition -FieldXml @'
<Field ID="{b840cd52-087f-4d75-9087-93ef3f902f58}" Type="Text" MaxLength="300" Name="ShelterSummary" StaticName="ShelterSummary" DisplayName="Shelter Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsHealthBackstop = New-FieldDefinition -FieldXml @'
<Field ID="{de48a28f-7efb-4646-86a0-f823a983758b}" Type="Text" MaxLength="300" Name="HealthBackstop" StaticName="HealthBackstop" DisplayName="Health Backstop" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsHealthSummary = New-FieldDefinition -FieldXml @'
<Field ID="{d4c41cc1-29c4-4c99-8b70-c14b81b945de}" Type="Text" MaxLength="300" Name="HealthSummary" StaticName="HealthSummary" DisplayName="Health Summary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;


$global:FieldDefReportsEHUDeployed = New-FieldDefinition -FieldXml @'
<Field ID="{813610f9-9238-422d-8add-072f47c64205}" Type="Boolean" Name="EHUDeployed" StaticName="EHUDeployed" DisplayName="EHU Deployed" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsEHUDeployedDate = New-FieldDefinition -FieldXml @'
<Field ID="{e942b3da-39f2-462e-ae2a-ea7e667ef4d4}" Type="DateTime" Name="EHUDeployedDate" StaticName="EHUDeployedDate" DisplayName="EHU Deployed Date" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsOutputTracker = New-FieldDefinition -FieldXml @'
<Field ID="{4ad1461f-cdfd-45a8-b60e-33c8ce0201fa}" Type="Text" MaxLength="300" Name="OutputTracker" StaticName="OutputTracker" DisplayName="OutputTracker" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsNutritionSummary = New-FieldDefinition -FieldXml @'
<Field ID="{fbc8919c-c259-4b90-adba-3ac1c38bd1a8}" Type="Text" MaxLength="300" Name="NutritionSummary" StaticName="NutritionSummary" DisplayName="NutritionSummary" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

###### HR

$global:FieldDefReportsNationalStaffNumber = New-FieldDefinition -FieldXml @'
<Field ID="{31ab478f-4606-4ec8-b3c6-6da5c62a5489}" Type="Number" Decimals="0" Name="NationalStaffNumber" StaticName="NationalStaffNumber" DisplayName="National Staff Number" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsInternationalStaffNumber = New-FieldDefinition -FieldXml @'
<Field ID="{e3508f0f-4f38-45d5-b676-e69831c9b9e6}" Type="Number" Decimals="0" Name="InternationalStaffNumber" StaticName="InternationalStaffNumber" DisplayName="International Staff Number" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsDeploymentTrackerLink = New-FieldDefinition -FieldXml @'
<Field ID="{16835935-f94c-460b-9cbd-5f717c31e56d}" Type="Text" MaxLength="255" Name="DeploymentTrackerLink" StaticName="DeploymentTrackerLink" DisplayName="Deployment Tracker Link" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#### S and S

$global:FieldDefReportsSecurityContext = New-FieldDefinition -FieldXml @'
<Field ID="{dfb22f7f-1721-4166-9b37-607d8dedea5d}" Type="Text" MaxLength="300" Name="SecurityContext" StaticName="SecurityContext" DisplayName="Security Context" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsSecurityChallenges = New-FieldDefinition -FieldXml @'
<Field ID="{ed3c44a0-9827-411b-9f43-f7b7135d3241}" Type="Text" MaxLength="300" Name="SecurityChallenges" StaticName="SecurityChallenges" DisplayName="Security Challenges" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsSecurityManagement = New-FieldDefinition -FieldXml @'
<Field ID="{01fb4146-2e2a-4e09-8f5d-7ca20e47c047}" Type="Text" MaxLength="300" Name="SecurityManagement" StaticName="SecurityManagement" DisplayName="Security Management" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#######Child safegaurding

$global:FieldDefReportsStaffChildSafegaurding = New-FieldDefinition -FieldXml @'
<Field ID="{50560281-9e50-4820-9420-432e0bf535eb}" Type="Number" Decimals="0" Name="StaffChildSafegaurding" StaticName="StaffChildSafegaurding" DisplayName="Staff Child Safegaurding" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsSafegaurdingFocalPoint = New-FieldDefinition -FieldXml @'
<Field ID="{f8e55de2-80d3-4653-ad24-fd8fadfd6365}" Type="Text" MaxLength="300" Name="SafegaurdingFocalPoint" StaticName="SafegaurdingFocalPoint" DisplayName="Safegaurding Focal Point" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsSafegaurdingRisks = New-FieldDefinition -FieldXml @'
<Field ID="{d37de8e6-bd1b-4905-89e6-2a376b03ef56}" Type="Text" MaxLength="300" Name="SafegaurdingRisks" StaticName="SafegaurdingRisks" DisplayName="Safegaurding Risks" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

##### Adv comms and media

$global:FieldDefReportsCommsPack = New-FieldDefinition -FieldXml @'
<Field ID="{6d4850d3-6da6-48b3-bfbd-853473270f0d}" Type="Text" MaxLength="300" Name="CommsPack" StaticName="CommsPack" DisplayName="Comms Pack" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsMediaCoverage = New-FieldDefinition -FieldXml @'
<Field ID="{04d1b173-dc44-4d44-aa51-d86a1cb2ea79}" Type="Text" MaxLength="300" Name="MediaCoverage" StaticName="MediaCoverage" DisplayName="Media Coverage" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsSpokespeople = New-FieldDefinition -FieldXml @'
<Field ID="{8450ac34-ce81-4754-9220-5e1a4c831d28}" Type="Text" MaxLength="300" Name="Spokespeople" StaticName="Spokespeople" DisplayName="Spokespeople" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsAdvocacyActions = New-FieldDefinition -FieldXml @'
<Field ID="{5fe8f97f-af63-4dfa-ba30-5c2a1908b224}" Type="Text" MaxLength="300" Name="AdvocacyActions" StaticName="AdvocacyActions" DisplayName="Advocacy Actions" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

####### Emergency Supply chain

$global:FieldDefReportsPrepositionedStock = New-FieldDefinition -FieldXml @'
<Field ID="{ee55f860-4d3d-4b1d-9a6a-1209e278c047}" Type="Boolean" Name="PrepositionedStock" StaticName="PrepositionedStock" DisplayName="Prepositioned Stock" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsForThisResponse = New-FieldDefinition -FieldXml @'
<Field ID="{eb8157e1-dc6d-4912-9ecf-2e3bbd5e798b}" Type="Boolean" Name="ForThisResponse" StaticName="ForThisResponse" DisplayName="Prepositioned Stock for This Response" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsPlannedProcurement = New-FieldDefinition -FieldXml @'
<Field ID="{9ecf6c99-fa9a-4904-a514-dba6b488fbc9}" Type="Number" Decimals="0" Name="PlannedProcurement" StaticName="PlannedProcurement" DisplayName="Planned Procurement" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReportsProcurementSpend = New-FieldDefinition -FieldXml @'
<Field ID="{313d5a0e-c2ed-44d4-8c82-622de0ae1993}" Type="Number" Decimals="0" Name="ProcurementSpend" StaticName="ProcurementSpend" DisplayName="Procurement Spend" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;


$global:CTDefReports = New-ContentTypeDefinition -ID "0x0100C2DB3C6656AA48D89CB763E667C1FC48" -Name "Reports" -Group $CTGroup -Description "Reports";

$global:ListReports = New-ListDefinition -ListTitle $global:ReportsListTitle -ListUrl $global:ReportsListName -Description "Reports" -Template $CustomListTemplate -ContentTypes @($global:CTDefReports.Name);

#endregion



#region Response Codes

$global:ResponseCodesListTitle = "Response Codes";
$global:ResponseCodesListName = "ResponseCodes";

$global:FieldDefResponseCodesCode = New-FieldDefinition -FieldXml @'
<Field ID="{a5a350ae-3186-463e-82c8-00b75ed87a76}" Type="Text" MaxLength="255" Name="Code" StaticName="Code" DisplayName="Code" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefResponseCodesDescription = New-FieldDefinition -FieldXml @'
<Field ID="{86efff91-fb97-4b4b-9a63-04f39887ae5f}" Type="Text" MaxLength="255" Name="Description" StaticName="Description" DisplayName="Description" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefResponseCodesStartDate = New-FieldDefinition -FieldXml @'
<Field ID="{d9b4c1d6-f184-4a65-9c00-493bf9a34b93}" Type="DateTime" Name="StartDate" StaticName="StartDate" DisplayName="Start Date" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefResponseCodesRegion = New-FieldDefinition -FieldXml @'
<Field ID="{2bb7fbac-be0a-4387-82e5-5a43a5d81e28}" Type="Text" MaxLength="255" Name="Region" StaticName="Region" DisplayName="Region" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefResponseCodesCountry = New-FieldDefinition -FieldXml @'
<Field ID="{47ae60a7-9a97-4e42-abb7-01a2bb7fdf44}" Type="Text" MaxLength="255" Name="Country" StaticName="Country" DisplayName="Country" 
Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

# $global:FieldDefUserProfileId = New-FieldDefinition -FieldXml @'
# <Field ID="{2e82382f-31f6-4044-9cc6-677ea1c6e9ff}" Type="Number" Decimals="0" Name="UserId" StaticName="UserId" DisplayName="User ID" 
# Group="_OMT" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="FALSE"
# ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;

# $global:FieldDefUserProfileEmail = New-FieldDefinition -FieldXml @'
# <Field ID="{13f3d91e-7790-4f42-942f-50276c784d15}" Type="Text" MaxLength="255" Name="UserEmail" StaticName="UserEmail" DisplayName="User Email" 
# Group="_OMT" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
# ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
# '@;


$global:CTDefResponseCodes = New-ContentTypeDefinition -ID "0x0100C2DB3C6656AA48D89CA763E657C1FC48" -Name "Response Codes" -Group $CTGroup -Description "Response Codes";

$global:ListResponseCodes = New-ListDefinition -ListTitle $global:ResponseCodesListTitle -ListUrl $global:ResponseCodesListName -Description "Response Codes" -Template $CustomListTemplate -ContentTypes @($global:CTDefResponseCodes.Name);

#endregion

