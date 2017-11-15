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
    Write-Output @($global:TARManagementGroupName, $global:TARSystemAdminGroupName, $global:TARBudgetApproversManagementGroupName, $global:TARAllUsersGroupName,  
        $global:TARBudgetApproversGroupName, $global:TARSuperBudgetApproversGroupName, $global:TARGSSSiteAdminGroupName, $global:TARGSSApproversGroupName,
        $global:TARFinanceGroupName, $global:TARExecutivePersonalAssistants);
}

#endregion 

#region Lists Collection
function Get-ListNames
{
    Write-Output @($global:UserProfileListTitle, $global:MembersListTitle, $global:RegionsListTitle, $global:CountriesListTitle, $global:AccountCodesListTitle, 
    $global:OrgUnitTypesListTitle, $global:OrgUnitsListTitle, $global:CurrenciesListTitle, $global:TARRequestsListTitle, $global:TARDraftsListTitle, 
    $global:TAREmailTemplatesListTitle, $global:EIFRequestsListTitle, $global:EIFDraftsListTitle, $global:TARSettingsListTitle,$global:WorkflowHistoryListTitle,
    $global:WorkflowTasksListTitle);
}

#endregion

#region Common

$global:FieldDefGroup = "_TAR";

$global:CTGroup = "_TAR";

$CustomListTemplate = "Custom List";

$global:FieldDefDescription = New-FieldDefinition @'
    <Field ID="{121E98BD-D181-4A76-B83D-5D2267ABE564}" Type="Text" MaxLength="255" Name="TAR_Description" StaticName="TAR_Description" DisplayName="Description" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefState = New-FieldDefinition @'
    <Field ID="{8249971A-EF51-4E7B-A16D-A70E6151FDA5}" Type="Choice" Name="TAR_State" StaticName="TAR_State" DisplayName="Organization Unit State"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE">
        <Default>Active</Default>
        <CHOICES>
            <CHOICE>Active</CHOICE>
            <CHOICE>Inactive</CHOICE>
        </CHOICES>
    </Field>
'@;

$global:FieldDefCode = New-FieldDefinition @'
    <Field ID="{1D8D9AD7-3D27-4110-9FE1-C94182B705F4}" Type="Text" MaxLength="3" Name="TAR_Code" StaticName="TAR_Code" DisplayName="Code" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOrgUnitsLookup = New-FieldDefinition @'
    <Field ID="{EE911242-5E0E-4D98-A1A9-481D85120711}" Type="Lookup" List="{{ListContext}}" ShowField="Title" 
    Name="TAR_OrgUnitLookup" StaticName="TAR_OrgUnitLookup" DisplayName="Organization Unit"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefRegionsLookup = New-FieldDefinition @'
    <Field ID="{D1B63900-8FB8-4876-9734-F0954BBC7D14}" Type="Lookup" List="{{ListContext}}" ShowField="Title"
    Name="TAR_RegionLookup" StaticName="TAR_RegionLookup" DisplayName="Region" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefCountriesLookupMulti = New-FieldDefinition @'
    <Field ID="{45B147D9-1C5C-4813-A292-60AF0EFD98B7}" Type="LookupMulti" List="{{ListContext}}" ShowField="Title" Mult="TRUE"
    Name="TAR_CountriesLookup" StaticName="TAR_CountriesLookup" DisplayName="Countries"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefDirector = New-FieldDefinition @'
    <Field ID="{72DE3DB7-7B67-43EA-9435-1AF0724646CC}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_Director" StaticName="TAR_Director" DisplayName="Director"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefRequester = New-FieldDefinition @'
    <Field ID="{FE640F92-3989-4B91-8CF8-BC4B686424A7}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_Requester" StaticName="TAR_Requester" DisplayName="Requester"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEmergencyContacts = New-FieldDefinition @'
    <Field ID="{91A0DBA1-68DE-4C56-9E54-EDE12E6088CB}" Type="Note" Name="TAR_EmergencyContacts" StaticName="TAR_EmergencyContacts" DisplayName="Emergency Contacts" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefSelectedEmergencyContacts = New-FieldDefinition @'
    <Field ID="{53C831C0-4BC9-4A15-8760-A611891A912F}" Type="Note" Name="TAR_SelectedEmergencyContacts" StaticName="TAR_SelectedEmergencyContacts" DisplayName="Emergency Contacts" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefPhotoID = New-FieldDefinition @'
    <Field ID="{DA5E6CE8-00A0-4366-A977-CC5257C98052}" Type="Text" MaxLength="255" Name="TAR_PhotoId" StaticName="TAR_PhotoId" DisplayName="Photo ID" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefMedicalEmergencyCard = New-FieldDefinition @'
    <Field ID="{656D9C0C-6C23-40FB-9B09-7F680731825C}" Type="Text" MaxLength="255" Name="TAR_MedicalEmergencyCard" StaticName="TAR_MedicalEmergencyCard" DisplayName="Medical Emergency Card" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefMedicalProviderName = New-FieldDefinition @'
    <Field ID="" Type="Text" MaxLength="255" Name="TAR_MedicalProviderName" StaticName="TAR_MedicalProviderName" DisplayName="Medical Provider Name" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefPolicyNumber = New-FieldDefinition @'
    <Field ID="" Type="Text" MaxLength="255" Name="TAR_PolicyNumber" StaticName="TAR_PolicyNumber" DisplayName="Policy Number" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefGSSTraining = New-FieldDefinition @'
    <Field ID="{3BB0F77A-173A-4742-9EEC-809BF324FC35}" Type="Text" MaxLength="255" Name="TAR_GSSTraining" StaticName="TAR_GSSTraining" DisplayName="GSS Training" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefGSSTrainingDate = New-FieldDefinition @'
    <Field ID="{6CDD188B-EBC7-45AD-89ED-43A998580591}" Type="DateTime" Name="TAR_GSSTrainingDate" StaticName="TAR_GSSTrainingDate" DisplayName="GSS Training Date"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefDestinations = New-FieldDefinition @'
    <Field ID="{13022FFE-74E0-4421-A6C9-DEB150E09371}" Type="Note" Name="TAR_Destinations" StaticName="TAR_Destinations" DisplayName="Destinations"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefInformationRead = New-FieldDefinition @'
    <Field ID="{D17241AB-13A0-42A7-8880-A486AA91DCDB}" Type="Note" Name="TAR_InformationRead" StaticName="TAR_InformationRead" DisplayName="Information Read"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefAdditionalStaffMember = New-FieldDefinition @'
    <Field ID="{8BC16DB6-8F85-470F-BA50-10A580B56FC9}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_AdditionalStaffMember" StaticName="TAR_AdditionalStaffMember" DisplayName="Additional Staff Member"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefLineManager = New-FieldDefinition @'
    <Field ID="{B9C3B685-A939-4697-AB43-9C5CAC685BB6}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_LineManager" StaticName="TAR_LineManager" DisplayName="Line Manager"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#endregion

#region User Profile

$global:UserProfileListName = "UserProfile";
$global:UserProfileListTitle = "User Profile";

$global:FieldDefUserProfileId = New-FieldDefinition -FieldXml @'
    <Field ID="{369EE618-B744-4847-B716-0808A35EA449}" Type="Number" Decimals="0" Name="TAR_UserId" StaticName="TAR_UserId" DisplayName="User ID" 
    Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileEmail = New-FieldDefinition -FieldXml @'
    <Field ID="{673F266C-7FE0-47A2-9CD0-213FAB4DD584}" Type="Text" MaxLength="255" Name="TAR_UserEmail" StaticName="TAR_UserEmail" DisplayName="User Email" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileFirstName = New-FieldDefinition -FieldXml @'
    <Field ID="{9E710AC6-8D06-45EB-B9A7-1360900B4219}" Type="Text" MaxLength="255" Name="TAR_FirstName" StaticName="TAR_FirstName" DisplayName="First Name" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileLastName = New-FieldDefinition -FieldXml @'
    <Field ID="{3BC2ECEA-5AD3-4757-8825-935C92776EA0}" Type="Text" MaxLength="255" Name="TAR_LastName" StaticName="TAR_LastName" DisplayName="Last Name" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileJobTitle = New-FieldDefinition -FieldXml @'
    <Field ID="{D7CC926E-5702-48A3-A133-5F971E78FBA7}" Type="Text" MaxLength="255" Name="TAR_JobTitle" StaticName="TAR_JobTitle" DisplayName="Job Title" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileDepartment = New-FieldDefinition -FieldXml @'
    <Field ID="{EF856865-92BA-40C7-9F4E-EC6726AF3533}" Type="Text" MaxLength="255" Name="TAR_Department" StaticName="TAR_Department" DisplayName="Department" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileOfficeLocation = New-FieldDefinition @'
    <Field ID="{77192737-40BC-44EF-807E-5CA5449E8BDB}" Type="Text" MaxLength="255" Name="TAR_OfficeLocation" StaticName="TAR_OfficeLocation" DisplayName="Office Location" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileLanguage = New-FieldDefinition @'
	<Field ID="{16B6629F-7489-418F-A83A-A6C5F2A32B23}" Type="Text" MaxLength="255" Name="TAR_UserLanguage" StaticName="TAR_UserLanguage" DisplayName="User Language" 
Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileExpensesCodes = New-FieldDefinition @'
    <Field ID="{CE0BB42D-8170-48DB-8C25-21A9654F2C35}" Type="Note" Name="TAR_ExpensesCodes" StaticName="TAR_ExpensesCodes" DisplayName="Expenses Codes" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileOthersAccess = New-FieldDefinition @'
    <Field ID="{C7E41C52-205D-42C7-A74D-38125ADE7D80}" Type="User" Name="TAR_ProfileOthersAccess" StaticName="TAR_ProfileOthersAccess" DisplayName="Who can access the profile"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefUserProfileHasAccess = New-FieldDefinition @'
    <Field ID="{4968F4D5-C263-4647-BD2F-85009DEAD466}" Type="UserMulti" Mult="TRUE" Name="TAR_ProfileHasAccess" StaticName="TAR_ProfileHasAccess" DisplayName="Has access to user profiles"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;


$global:CTDefUserProfile = New-ContentTypeDefinition -ID "0x0100C2DB3C6656AA48D89CA763E667C1FC37" -Name "User Profile" -Group $CTGroup -Description "TAR User Profile";

$global:ListUserProfile = New-ListDefinition -ListTitle $global:UserProfileListTitle -ListUrl $global:UserProfileListName -Description "User Profile for TAR" -Template $CustomListTemplate -ContentTypes @($global:CTDefUserProfile.Name);

#endregion 

#region Members

$global:MembersListTitle = "Members";
$global:MembersListName = "Members";

$global:FieldDefMembersProgramsThroughSCI = New-FieldDefinition @'
    <Field ID="{F6A23C3A-A531-495B-8D43-5C00DEB32B2B}" Type="Boolean" Name="TAR_ProgramsThroughSCI" StaticName="TAR_ProgramsThroughSCI" DisplayName="Programs through SCI"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefMembers = New-ContentTypeDefinition -ID "0x0100E6C5132FA4E44051AB20FDBBB03E9388" -Name "Members" -Group $CTGroup -Description "TAR Members";

$global:ListMembers = New-ListDefinition -ListTitle $global:MembersListTitle -ListUrl $global:MembersListName -Description "Members for TAR" -Template $CustomListTemplate -ContentTypes @($global:CTDefMembers.Name);

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

#region Account Codes

$global:AccountCodesListName = "AccountCodes";
$global:AccountCodesListTitle = "Account Codes";

$global:FieldDefAccountCode = New-FieldDefinition @'
    <Field ID="{96DBBD72-AD2E-4125-A32C-FE29E400D933}" Type="Number" Decimals="0" Name="TAR_AccountCode" StaticName="TAR_AccountCode" DisplayName="Account Code" 
    Group="_TAR" EnforceUniqueValues="TRUE" Indexed="TRUE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefAccountCodes = New-ContentTypeDefinition -ID "0x01007982CAB6A2E346F2BE2CE0BBDFCFC1DD" -Name "Account Codes" -Group $CTGroup -Description "TAR Account Codes";

$global:ListAccountCodes = New-ListDefinition -ListTitle $global:AccountCodesListTitle -ListUrl $global:AccountCodesListName -Description "Account Codes for TAR" -Template $CustomListTemplate -ContentTypes @($global:CTDefAccountCodes.Name);

#endregion

#region Organization Unit Types

$global:OrgUnitTypesListName = "OrganizationUnitTypes";
$global:OrgUnitTypesListTitle = "Organization Unit Types";

$global:FieldDefOrgUnitTypeUsedByMembers = New-FieldDefinition @'
    <Field ID="{0D675943-B723-4A02-B6B4-8A59F4C57E7E}" Type="Boolean" Name="TAR_UsedOnlyByMembers" StaticName="TAR_UsedOnlyByMembers" DisplayName="Used only by members" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefOrgUnitType = New-ContentTypeDefinition -ID "0x010048BAB82BB0EC48E69AC5CC6E6C18E1CC" -Name "Organization Unit Types" -Group $CTGroup -Description "TAR Organization Unit Types";

$global:ListOrgUnitType = New-ListDefinition -ListTitle $global:OrgUnitTypesListTitle -ListUrl $global:OrgUnitTypesListName -Description "Organization Unit Types for TAR" -Template $CustomListTemplate -ContentTypes @($global:CTDefOrgUnitType.Name);

#endregion

#region Organization Units

$global:OrgUnitsListName = "OrganizationUnits";
$global:OrgUnitsListTitle = "Organization Units";

$global:FieldDefOrgUnitsReportsTo = New-FieldDefinition @'
    <Field ID="{95C0FC2B-7EB0-4E6E-8839-37062BB7446C}" Type="Lookup" List="{{ListContext}}" ShowField="Title" 
    Name="TAR_OrgUnitReportsTo" StaticName="TAR_OrgUnitReportsTo" DisplayName="Reports To Organization Unit"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOrgUnitsManagedBy = New-FieldDefinition @'
    <Field ID="{C443998F-DCA0-48C5-9E04-CAEDB810992C}" Type="Lookup" List="{{ListContext}}" ShowField="Title"
    Name="TAR_OrgUnitManagedBy" StaticName="TAR_OrgUnitManagedBy" DisplayName="Managed By Country" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOrgUnitsBudgetApprovers = New-FieldDefinition @'
    <Field ID="{DFC28F39-EA2D-4ACD-8F91-CA7C42904565}" Type="UserMulti" Mult="TRUE" UserSelectionMode="PeopleOnly" 
    Name="TAR_BudgetApprovers" StaticName="TAR_BudgetApprovers" DisplayName="Budget Approvers"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefOrgUnitsType = New-FieldDefinition @'
    <Field ID="{7236E4C3-185D-4818-9958-F8368FD9783E}" Type="Lookup" List="{{ListContext}}" ShowField="Title" 
    Name="TAR_OrgUnitType" StaticName="TAR_OrgUnitType" DisplayName="Type" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefOrgUnits = New-ContentTypeDefinition -ID "0x0100B5663A5F0C924CB18E633461AF22E6D0" -Name "Organization Units" -Group $CTGroup -Description "TAR Organization Units";

$global:ListOrgUnits = New-ListDefinition -ListTitle $global:OrgUnitsListTitle -ListUrl $global:OrgUnitsListName -Description "Organization Units for TAR" -Template $CustomListTemplate -ContentTypes @($global:CTDefOrgUnits.Name);

#endregion

#region Currencies

$global:CurrenciesListTitle = "Currencies";
$global:CurrenciesListName = "Currencies";

$global:FieldDefCurrenciesNumber = New-FieldDefinition @'
    <Field ID="{840E8759-A2DF-4C21-8C4E-4D06B3CA13BE}" Type="Text" MaxLength="3" Name="TAR_CurrencyNumber" StaticName="TAR_CurrencyNumber" DisplayName="Number"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" /> 
'@;

$global:CTDefCurrencies = New-ContentTypeDefinition -ID "0x010094224A4A0E594043BAC2C90584B20923" -Name "Currencies" -Group $CTGroup -Description "TAR Currencies";

$global:ListCurrencies = New-ListDefinition -ListTitle $global:CurrenciesListTitle -ListUrl $global:CurrenciesListName -Description "Currencies for TAR" -Template $CustomListTemplate -ContentTypes @($global:CTDefCurrencies.Name);

#endregion 

#region TAR Requests

$global:TARRequestsListTitle = "TAR Requests";
$global:TARRequestsListName = "TARRequests";

$global:FieldDefTARTraveller = New-FieldDefinition @'
    <Field ID="{09B73495-16A6-44AE-84C1-2A4B504C4C6D}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_Traveller" StaticName="TAR_Traveller" DisplayName="Traveller"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARTypeOfTravel = New-FieldDefinition @'
    <Field ID="{EFD13BA4-CDE3-4D03-B54F-B94C5A26930B}" Type="Text" MaxLength="255" Name="TAR_TypeOfTravel" StaticName="TAR_TypeOfTravel" DisplayName="Type of travel"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARVisaRequired = New-FieldDefinition @'
    <Field ID="{CA754B88-5F76-4DDB-A46D-8ECB890E06D6}" Type="Text" MaxLength="255" Name="TAR_VisaRequired" StaticName="TAR_VisaRequired" DisplayName="Visa required"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARVisaNumber = New-FieldDefinition @'
    <Field ID="{89020ED8-851C-44A5-8DD7-C820A4961A0B}" Type="Text" MaxLength="255" Name="TAR_VisaNumber" StaticName="TAR_VisaNumber" DisplayName="Visa number"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARReadPDI = New-FieldDefinition @'
    <Field ID="{27B3B9E8-9047-4747-A6BC-7CC2B8950BFB}" Type="Text" MaxLength="255" Name="TAR_ReadPDI" StaticName="TAR_ReadPDI" DisplayName="Read PDI procedure"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARUsaidFunds = New-FieldDefinition @'
    <Field ID="{B3DDD905-2FED-498B-8445-3D92D3068754}" Type="Text" MaxLength="255" Name="TAR_UsaidFunds" StaticName="TAR_UsaidFunds" DisplayName="USAID Funds"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARAppropriateVaccination = New-FieldDefinition @'
    <Field ID="{AF0DF072-5511-4833-A94D-9EC77FE508F8}" Type="Text" MaxLength="255" Name="TAR_AppropriateVaccination" StaticName="TAR_AppropriateVaccination" DisplayName="Appropriate vaccination received"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARLondonOfficeLocation = New-FieldDefinition @'
    <Field ID="" Type="Text" MaxLength="255" Name="TAR_LondonOfficeLocation" StaticName="TAR_LondonOfficeLocation" DisplayName="Located in London office" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARTravelAdvances = New-FieldDefinition @'
    <Field ID="{29DD6F5E-1300-40AE-A9D6-8D59CF91C39E}" Type="Note" Name="TAR_TravelAdvances" StaticName="TAR_TravelAdvances" DisplayName="Travel Advances"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARPurposeOfTravel = New-FieldDefinition @'
    <Field ID="{5BB207FF-C884-4193-A45F-3CE030C7AB2F}" Type="Note" Name="TAR_PurposeOfTravel" StaticName="TAR_PurposeOfTravel" DisplayName="Purpose of travel"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARApprovedByDirector = New-FieldDefinition @'
    <Field ID="{11021A0E-EC24-4084-85D1-2A5B95C3AC8B}" Type="Text" MaxLength="255" Name="TAR_ApprovedByDirector" StaticName="TAR_ApprovedByDirector" DisplayName="Approved by Director"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARAppropriateEmergencyContacts = New-FieldDefinition @'
    <Field ID="{205CECA7-DA6E-4967-97FD-9B6880DB1A71}" Type="Text" MaxLength="255" Name="TAR_AppropriateEmergencyContacts" StaticName="TAR_AppropriateEmergencyContacts" DisplayName="Has Appropriate Emergency Contacts"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARBudgetSession = New-FieldDefinition @'
    <Field ID="{567FF0B2-4F6D-4271-8DCA-DAAC60E7843C}" Type="Note" Name="TAR_BudgetSession" StaticName="TAR_BudgetSession" DisplayName="Budget Session"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTAROtherEstimatedCosts = New-FieldDefinition @'
    <Field ID="{25A72C07-5A10-4982-B33F-69AF1F6BD87D}" Type="Note" Name="TAR_OtherEstimatedCosts" StaticName="TAR_OtherEstimatedCosts" DisplayName="Other estimated costs"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@; 

$global:FieldDefTARBudgetCodes = New-FieldDefinition @'
    <Field ID="{0CC51167-7407-43ED-83B7-B9EABCFA2905}" Type="Note" Name="TAR_BudgetCodes" StaticName="TAR_BudgetCodes" DisplayName="Budget Codes" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARAdditionalInformation = New-FieldDefinition @'
    <Field ID="{67D6C7CA-4164-49E7-8266-BDE26B3B405A}" Type="Note" Name="TAR_AdditionalInformation" StaticName="TAR_AdditionalInformation" DisplayName="Additional Information"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARTravelCoordinator = New-FieldDefinition @'
    <Field ID="{3BFCCEE2-3815-433C-82C0-176DC40068C3}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_TravelCoordinator" StaticName="TAR_TravelCoordinator" DisplayName="Travel Coordinator"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefTARBudgetApprover = New-FieldDefinition @'
    <Field ID="{202757DA-F70D-4822-9378-A505A982932D}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_BudgetApprover" StaticName="TAR_BudgetApprover" DisplayName="Budget Approver"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefBudgetApprovalStatus = New-FieldDefinition @'
    <Field ID="{C2CF53B1-E097-49F3-A08A-982D6B3FCF21}" Type="Choice" Name="TAR_BudgetApprovalStatus" StaticName="TAR_BudgetApprovalStatus" DisplayName="Budget Approval Status"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE">
        <Default>None</Default>
        <CHOICES>
            <CHOICE>None</CHOICE>
            <CHOICE>Pending</CHOICE>
            <CHOICE>Approved</CHOICE>
            <CHOICE>Rejected</CHOICE>
        </CHOICES>
    </Field>
'@;

$global:FieldDefBudgetApprovalTimeStamp = New-FieldDefinition @'
    <Field ID="{36F9A76A-3C64-42C4-896E-8F658164D251}" Type="DateTime" Name="TAR_BudgetApprovalTimestamp" StaticName="TAR_BudgetApprovalTimestamp" DisplayName="Budget Approval Timestamp"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefGSSAprovalStatus = New-FieldDefinition @'
    <Field ID="{D1B0A6C2-D77E-4C34-9216-5DE6BF5EC017}" Type="Choice" Name="TAR_GSSApprovalStatus" StaticName="TAR_GSSApprovalStatus" DisplayName="GSS Approval Status"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE">
        <Default>None</Default>
        <CHOICES>
            <CHOICE>None</CHOICE>
            <CHOICE>Pending</CHOICE>
            <CHOICE>Approved</CHOICE>
            <CHOICE>Rejected</CHOICE>
        </CHOICES>
    </Field>
'@;

$global:FieldDefGSSApprovalTimestamp = New-FieldDefinition @'
    <Field ID="{F30379A9-2C08-42BC-A450-C3004A2234BF}" Type="DateTime" Name="TAR_GSSApprovalTimestamp" StaticName="TAR_GSSApprovalTimestamp" DisplayName="GSS Approval Timestamp"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefRequiresGssApproval = New-FieldDefinition @'
    <Field ID="{18C91DAB-D4BD-4E6D-AB07-EF70AB7C1D32}" Type="Boolean" Name="TAR_RequiresGssApproval" StaticName="TAR_RequiresGssApproval" DisplayName="Requires GSS Approval"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefDepartureDate = New-FieldDefinition @'
    <Field ID="{8C11EEA2-AEC8-46D9-B20D-5386F708D26D}" Type="DateTime" Name="TAR_DepartureDate" StaticName="TAR_DepartureDate" DisplayName="Departure Date"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefReturnDate = New-FieldDefinition @'
    <Field ID="{2219C512-D705-43C4-9EE5-7300976A8B71}" Type="DateTime" Name="TAR_ReturnDate" StaticName="TAR_ReturnDate" DisplayName="Return Date"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@

$global:CTDefTARRequests = New-ContentTypeDefinition -ID "0x0100750DED44DE8C448F9F59414BCE29DFB8" -Name "TAR Requests" -Group $CTGroup -Description "TAR Requests";

$global:ListTARRequests = New-ListDefinition -ListTitle $global:TARRequestsListTitle -ListUrl $global:TARRequestsListName -Description "TAR Requests" -Template $CustomListTemplate -ContentTypes @($global:CTDefTARRequests.Name);

#endregion

#region TAR Drafts

$global:TARDraftsListTitle = "TAR Drafts";
$global:TARDraftsListName = "TARDrafts";

$global:CTDefTARDrafts = New-ContentTypeDefinition -ID "0x01009BBEA8AD6FEB40CCAC2033A7118BCBA4" -Name "TAR Drafts" -Group $CTGroup -Description "TAR Drafts";

$global:ListTARDrafts = New-ListDefinition -ListTitle $global:TARDraftsListTitle -ListUrl $global:TARDraftsListName -Description "TAR Drafts" -Template $CustomListTemplate -ContentTypes @($global:CTDefTARDrafts.Name);

#endregion

#region TAR Archive

$global:FieldDefTARCreatedDate = New-FieldDefinition @'
    <Field ID="{519EB602-DBFF-462C-BB10-4BAEC52492FF}" Type="DateTime" Name="TAR_CreatedDate" StaticName="TAR_CreatedDate" DisplayName="TAR Created"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@

$global:CTDefTARArchiveRequests = New-ContentTypeDefinition -ID "0x0100E29E9FE2899646D0BC533766A9EC844A" -Name "TAR Archive Requests" -Group $CTGroup -Description "TAR Archive Requests";

#endregion

#region EIF

$global:EIFRequestsListTitle = "EIF Requests";
$global:EIFRequestsListName = "EIFRequests";

$global:FieldDefEIFStaffResponsibleForGuest = New-FieldDefinition @'
    <Field ID="{559F75CF-3D09-46BF-87EF-C69B735907C9}" Type="User" UserSelectionMode="PeopleOnly" Name="TAR_StaffResponsibleForGuest" StaticName="TAR_StaffResponsibleForGuest" DisplayName="Staff responsible for guest traveller"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFFirstName = New-FieldDefinition @'
    <Field ID="{82E1D8A6-73E6-4842-BF9D-E0FE746AC09A}" Type="Text" MaxLength="255" Name="TAR_FirstName" StaticName="TAR_FirstName" DisplayName="First name"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFLastName = New-FieldDefinition @'
    <Field ID="{31E55D80-046E-4B59-B724-82965A20E718}" Type="Text" MaxLength="255" Name="TAR_LastName" StaticName="TAR_LastName" DisplayName="Last name"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFContactNumber = New-FieldDefinition @'
    <Field ID="{FBBBFC40-14CB-4BBE-95C7-249E0A2B87F0}" Type="Text" MaxLength="255" Name="TAR_ContactNumber" StaticName="TAR_ContactNumber" DisplayName="Contact number"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFDateOfBirth = New-FieldDefinition @'
    <Field ID="{DC4C8098-70E5-4892-8454-BAF38899E0D1}" Type="DateTime" Name="TAR_DateOfBirth" StaticName="TAR_DateOfBirth" DisplayName="Date of birth"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFPassportNumber = New-FieldDefinition @'
    <Field ID="{0747B5CA-A7C7-4BEA-AD9F-834C11B42C15}" Type="Text" MaxLength="255" Name="TAR_PassportNumber" StaticName="TAR_PassportNumber" DisplayName="Passport number"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFPassportCountry = New-FieldDefinition @'
    <Field ID="{7A68D5FB-9988-4C6B-92AE-9EEF9CC96D64}" Type="Text" MaxLength="255" Name="TAR_PassportCountry" StaticName="TAR_PassportCountry" DisplayName="Passport's country of issue"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFCountryOfOrigin = New-FieldDefinition @'
    <Field ID="{93C02836-5CF2-46B8-8016-A0476DC924A3}" Type="Text" MaxLength="255" Name="TAR_CountryOfOrigin" StaticName="TAR_CountryOfOrigin" DisplayName="Country of origin"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFVisaNumbers = New-FieldDefinition @'
    <Field ID="{224C111B-161D-43D4-8083-C383916329C1}" Type="Note" Name="TAR_VisaNumbers" StaticName="TAR_VisaNumbers" DisplayName="VISA Number(s) for countries you are visiting"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFEmergencyContactName = New-FieldDefinition @'
    <Field ID="{65D103A2-56F5-4F93-8464-9C09929C15D8}" Type="Text" MaxLength="255" Name="TAR_EmergencyContactName" StaticName="TAR_EmergencyContactName" DisplayName="Emergency contact name"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFEmergencyContactRelationship = New-FieldDefinition @'
    <Field ID="{89121267-14B3-4AF2-8BD2-1D3DBE26D309}" Type="Text" MaxLength="255" Name="TAR_EmergencyContactRelationship" StaticName="TAR_EmergencyContactRelationship" DisplayName="Emergency contact relationship"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFEmergencyContactEmail = New-FieldDefinition @'
    <Field ID="{DC4527FC-E088-45C1-AE9C-FCB84A97030B}" Type="Text" MaxLength="255" Name="TAR_EmergencyContactEmail" StaticName="TAR_EmergencyContactEmail" DisplayName="Emergency contact email"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFEmergencyContactHomePhone = New-FieldDefinition @'
    <Field ID="{51C785A2-5085-46F5-95C7-09638F4E623D}" Type="Text" MaxLength="255" Name="TAR_EmergencyContactHomePhone" StaticName="TAR_EmergencyContactHomePhone" DisplayName="Emergency contact home phone"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFEmergencyContactMobilePhone = New-FieldDefinition @'
    <Field ID="{E7FB5B0E-C9B5-4782-8E9E-666D9FAB0C25}" Type="Text" MaxLength="255" Name="TAR_EmergencyContactMobilePhone" StaticName="TAR_EmergencyContactMobilePhone" DisplayName="Emergency contact mobile phone"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

#destinations from TAR

$global:FieldDefEIFTravelRouteDetails = New-FieldDefinition @'
    <Field ID="{B4249E29-D735-40FD-80EF-B0F91016BD5A}" Type="Note" Name="TAR_TravelRouteDetails" StaticName="TAR_TravelRouteDetails" DisplayName="Travel/Route Details"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFMedicalConditions = New-FieldDefinition @'
    <Field ID="{1F8A3B8B-4E48-45E0-A57C-12382481C3EE}" Type="Note" Name="TAR_MedicalConditions" StaticName="TAR_MedicalConditions" DisplayName="Medical conditions"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFBloodType = New-FieldDefinition @'
    <Field ID="{0BD9EAF4-53CA-4D7B-927C-4C6541657C9E}" Type="Text" MaxLength="255" Name="TAR_BloodType" StaticName="TAR_BloodType" DisplayName="Blood type"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFInsurancePolicyNumber = New-FieldDefinition @'
    <Field ID="{9FA20386-55C7-444D-8EDF-513EA41A6722}" Type="Text" MaxLength="255" Name="TAR_InsurancePolicyNumber" StaticName="TAR_InsurancePolicyNumber" DisplayName="Insurance policy number"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFInsuranceCompany = New-FieldDefinition @'
    <Field ID="{46195F44-A87E-482B-9BBA-4A3CE8E0BE5F}" Type="Text" MaxLength="255" Name="TAR_InsuranceCompany" StaticName="TAR_InsuranceCompany" DisplayName="Insurance company"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFInsuranceCompanyPhone = New-FieldDefinition @'
    <Field ID="{91DCC4BB-9D2C-41B4-9AF0-03E6F347A8BB}" Type="Text" MaxLength="255" Name="TAR_InsuranceCompanyPhone" StaticName="TAR_InsuranceCompanyPhone" DisplayName="Insurance company phone number"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFInsuranceContact = New-FieldDefinition @'
    <Field ID="{8D733A0E-ED84-4BB3-8987-7DAA5B9517B4}" Type="Text" MaxLength="255" Name="TAR_InsuranceContact" StaticName="TAR_InsuranceContact" DisplayName="Insurance contact"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFAdditionalComments = New-FieldDefinition @'
    <Field ID="{77BB5065-2A8D-4A32-9ED4-0257AA83FC45}" Type="Note" Name="TAR_AdditionalComments" StaticName="TAR_AdditionalComments" DisplayName="Additional comments"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEIFTarId = New-FieldDefinition @'
    <Field ID="{3185B867-75C7-4E66-82CF-94859CBBCB4B}" Type="Text" MaxLength="255" Name="TAR_TarId" StaticName="TAR_TarId" DisplayName="TAR Id" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="FALSE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefEIFRequests = New-ContentTypeDefinition -ID "0x01007E033D8F6C774485808739AD989F502E" -Name "EIF Requests" -Group $CTGroup -Description "EIF Requests";

$global:ListEIFRequests = New-ListDefinition -ListTitle $global:EIFRequestsListTitle -ListUrl $global:EIFRequestsListName -Description "EIF Requests" -Template $CustomListTemplate -ContentTypes @($global:CTDefEIFRequests.Name);

#endregion

#region EIF Drafts 

$global:EIFDraftsListTitle = "EIF Drafts";
$global:EIFDraftsListName = "EIFDrafts";

$global:CTDefEIFDrafts = New-ContentTypeDefinition -ID "0x010004E50C0FF21240D898BCC5D3CC48593D" -Name "EIF Drafts" -Group $CTGroup -Description "EIF Drafts";

$global:ListEIFDrafts = New-ListDefinition -ListTitle $global:EIFDraftsListTitle -ListUrl $global:EIFDraftsListName -Description "EIF Drafts" -Template $CustomListTemplate -ContentTypes @($global:CTDefEIFDrafts.Name);

#endregion

#region TAR Settings

$global:TARSettingsListTitle = "TAR Settings";
$global:TARSettingsListName = "TARSettings";

$global:FieldDefSettingValue = New-FieldDefinition @'
    <Field ID="{CB2BC5BF-167B-488C-813C-6D6AD4D27B0F}" Type="Text" MaxLength="255" Name="TAR_SettingValue" StaticName="TAR_SettingValue" DisplayName="Setting Value"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefSettingUsedIn = New-FieldDefinition @'
    <Field ID="{A1631945-2900-4401-9A5B-3E438406985D}" Type="Text" MaxLength="255" Name="TAR_SettingUsedIn" StaticName="TAR_SettingUsedIn" DisplayName="Setting used in"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefSettingType = New-FieldDefinition @'
    <Field ID="{7BC39779-1713-4674-A10C-82FAF62FB5D1}" Type="Text" MaxLength="255" Name="TAR_SettingType" StaticName="TAR_SettingType" DisplayName="Setting type"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefTARSettings = New-ContentTypeDefinition -ID "0x0100E7494A52A6B94999AD2BB25DFCB3C9D5" -Name "TAR Settings" -Group $CTGroup -Description "TAR Settings";

$global:ListTARSettings = New-ListDefinition -ListTitle $global:TARSettingsListTitle -ListUrl $global:TARSettingsListName -Description "TAR Settings" -Template $CustomListTemplate -ContentTypes @($global:CTDefTARSettings.Name);

#endregion

#region Workflows Storage

$global:WorkflowHistoryTemplate = "Workflow History";
$global:TasksTemplate = "Tasks";

#region Workflow History List

$global:WorkflowHistoryListTitle = "TAR Workflow History";
$global:WorkflowHistoryListName = "TARWorkflowHistory";

$global:ListWorkflowHistory = New-ListDefinition -ListTitle $global:WorkflowHistoryListTitle -ListUrl $global:WorkflowHistoryListName -Description "TAR Workflow History List" -Template $global:WorkflowHistoryTemplate;

#endregion

#region Workflow Tasks List 

$global:WorkflowTasksListTitle = "TAR Workflow Tasks";
$global:WorkflowTasksListName = "TARWorkflowTasks";

$global:ListWorkflowTasks = New-ListDefinition -ListTitle $global:WorkflowTasksListTitle -ListUrl $global:WorkflowTasksListName -Description "TAR Workflow Tasks List" -Template $global:TasksTemplate -ContentTypes @("Task", "Workflow Task (SharePoint 2013)");

#endregion

#region Email Templates

$global:TAREmailTemplatesListTitle = "TAR Email Templates";
$global:TAREmailTemplatesListName = "TAREmailTemplates";

$global:FieldDefEmailSubject = New-FieldDefinition @'
    <Field ID="{CA13EA6D-B5D1-4C45-A059-EE953F2D5771}" Type="Text" MaxLength="255" Name="TAR_EmailSubject" StaticName="TAR_EmailSubject" DisplayName="Email Subject" 
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:FieldDefEmailContent = New-FieldDefinition @'
    <Field ID="{04588A98-73AF-483C-A194-E9DAA3FB0485}" Type="Note" Name="TAR_EmailContent" StaticName="TAR_EmailContent" DisplayName="Email Content" 
    RichText="TRUE" RichTextMode="FullHtml"
    Group="_TAR" EnforceUniqueValues="FALSE" Indexed="FALSE" Required="TRUE"
    ShowInDisplayForm="TRUE" ShowInEditForm="TRUE" ShowInListSettings="TRUE" ShowInNewForm="TRUE" />
'@;

$global:CTDefEmailTemplates = New-ContentTypeDefinition -ID "0x0100E6A311DE3C8944DABE6D6D55286666DC" -Name "TAR Email Templates" -Group $CTGroup -Description "TAR Email Templates";

$global:ListTAREmailTemplates = New-ListDefinition -ListTitle $global:TAREmailTemplatesListTitle -ListUrl $global:TAREmailTemplatesListName -Description "Email Templates for TAR Workflows" -Template $CustomListTemplate -ContentTypes @($global:CTDefEmailTemplates.Name);

#endregion 

#endregion