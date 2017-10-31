#region Storage

function EnsureStorage()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )
    
    EnsureFeatures -web $web
    
    EnsureSolutionStorage -web $web -docLibraryName $global:solutionStorageDocLibraryName

    EnsureUserProfile -web $web

    EnsureRegions -web $web

    EnsureCountries -web $web

    EnsureOrgUnitTypesList -web $web

    EnsureOrgUnits -web $web

    EnsureOrgUnitsCountries -web $web

    EnsureCurrencies -web $web

    EnsureMembers -web $web
    
    EnsureAccountCodes -web $web

    EnsureTARRequests -web $web
    
    EnsureTARDrafts -web $web
    
    EnsureEIFRequests -web $web

    EnsureEIFDrafts -web $web
    
    EnsureWorkflowHistory -web $web

    EnsureWorkflowTasks -web $web
    
    EnsureEmailTemplates -web $web

    EnsureTARSettings -web $web
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

        $listCollection.Add($docLibraryName, "Dedicated document library for storing the TAR app solution.", [Microsoft.SharePoint.SPListTemplateType]::DocumentLibrary)

        Log "Document library created..." -Level Success
    }

    $exportsLibrary = $listCollection.TryGetList($global:solutionExportDocLibraryName);
    if ($exportsLibrary -ne $null)
    {
        Log "Library $($global:solutionExportDocLibraryName) already exists" -Level Warning
    }
    else 
    {
        Log "Creating library $($global:solutionExportDocLibraryName)" -Level Warning

        $listCollection.Add($global:solutionExportDocLibraryName, "Dedicated document library for exporting TAR Requests", [Microsoft.SharePoint.SPListTemplateType]::DocumentLibrary)

        Log "Document library created..." -Level Success
    }

    Stop-SPAssignment -Global
}

function EnsureUserProfile()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    $args = @()
    $args += ("-StartIndex", 0)
    $args += ("-Count", 13)
    $cmd = "$PSScriptRoot\Generate-UserProfiles.ps1"

    Invoke-Expression "$cmd $args"
}

function EnsureCurrencies()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefDescription -ListContext $global:CurrenciesList.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefCurrenciesNumber -ListContext $global:CurrenciesList.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefCurrencies -FieldDefs $global:FieldDefDescription, $global:FieldDefCurrenciesNumber

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListCurrencies
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

function EnsureOrgUnitTypesList()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefDescription -ListContext $global:ListOrgUnitType.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefOrgUnitTypeUsedByMembers -ListContext $global:ListOrgUnitType.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefOrgUnitType -FieldDefs $global:FieldDefDescription, $global:FieldDefOrgUnitTypeUsedByMembers

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListOrgUnitType

    #HideTitleField -Web $web -ListName $global:OrgUnitTypesListTitle
}

function EnsureOrgUnits()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefCode -ListContext $global:ListOrgUnits.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefState -ListContext $global:ListOrgUnits.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefDirector -ListContext $global:ListOrgUnits.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefOrgUnitsBudgetApprovers -ListContext $global:ListOrgUnits.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefOrgUnitsType -ListContext $global:ListOrgUnitType.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefOrgUnits -FieldDefs $global:FieldDefCode, $global:FieldDefState,
         $global:FieldDefDirector, $global:FieldDefOrgUnitsType, $global:FieldDefOrgUnitsBudgetApprovers

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListOrgUnits

    #Ensure Lookup fields after the list has been created
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefOrgUnitsReportsTo -ListContext $global:ListOrgUnits.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefOrgUnitsManagedBy -ListContext $global:ListCountries.Title -webContext $web.ID

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefOrgUnits -FieldDefs $global:FieldDefOrgUnitsReportsTo, $global:FieldDefOrgUnitsManagedBy
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

function EnsureOrgUnitsCountries()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefCountriesLookupMulti -ListContext $global:ListCountries.Title -webContext $web.ID

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefOrgUnits -FieldDefs $global:FieldDefCountriesLookupMulti
}

function EnsureMembers()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefCode -ListContext $global:ListMembers.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefDescription -ListContext $global:ListMembers.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefState -ListContext $global:ListMembers.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefMembersProgramsThroughSCI -ListContext $global:ListMembers.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefMembers -FieldDefs $global:FieldDefCode, $global:FieldDefDescription, $global:FieldDefState, $global:FieldDefMembersProgramsThroughSCI

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListMembers

    HideTitleField -Web $web -ListName $global:MembersListTitle
}

function EnsureAccountCodes()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefAccountCode -ListContext $global:ListAccountCodes.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefAccountCodes -FieldDefs $global:FieldDefAccountCode

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListAccountCodes
}

function EnsureTARRequests() 
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field $web.Url -FieldDef $global:FieldDefRequester -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTraveller -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefLineManager -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefSelectedEmergencyContacts -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTypeOfTravel -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARVisaRequired -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARVisaNumber -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefPhotoID -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefMedicalEmergencyCard -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefMedicalProviderName -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefPolicyNumber -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARReadPDI -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARUsaidFunds -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARAppropriateVaccination -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTravelAdvances -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefGSSTraining -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefGSSTrainingDate -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARPurposeOfTravel -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARApprovedByDirector -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARAppropriateEmergencyContacts -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefDestinations -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARBudgetSession -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTAROtherEstimatedCosts -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARBudgetCodes -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARAdditionalInformation -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTravelCoordinator -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARBudgetApprover -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefInformationRead -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARLondonOfficeLocation -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefRequiresGssApproval -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefDepartureDate -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReturnDate -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefBudgetApprovalStatus -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefBudgetApprovalTimeStamp -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefGSSAprovalStatus -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefGSSApprovalTimestamp -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefAdditionalStaffMember -ListContext $global:ListTARRequests.Title -webContext $web.ID
    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefTARRequests -FieldDefs $global:FieldDefRequester, $global:FieldDefTARTraveller, $global:FieldDefLineManager,
        $global:FieldDefSelectedEmergencyContacts, $global:FieldDefTARTypeOfTravel, $global:FieldDefTARVisaRequired, $global:FieldDefTARVisaNumber, $global:FieldDefPhotoID, 
        $global:FieldDefMedicalEmergencyCard, $global:FieldDefMedicalProviderName, $global:FieldDefPolicyNumber,
        $global:FieldDefTARReadPDI, $global:FieldDefTARUsaidFunds, $global:FieldDefTARAppropriateVaccination, $global:FieldDefTARTravelAdvances,
        $global:FieldDefGSSTraining, $global:FieldDefGSSTrainingDate, $global:FieldDefTARPurposeOfTravel, $global:FieldDefTARApprovedByDirector, $global:FieldDefTARAppropriateEmergencyContacts,
        $global:FieldDefDestinations, $global:FieldDefTARBudgetSession, $global:FieldDefTAROtherEstimatedCosts, $global:FieldDefTARBudgetCodes,
        $global:FieldDefTARAdditionalInformation, $global:FieldDefTARTravelCoordinator, $global:FieldDefTARBudgetApprover, $global:FieldDefInformationRead, 
        $global:FieldDefTARLondonOfficeLocation, $global:FieldDefRequiresGssApproval, $global:FieldDefDepartureDate, $global:FieldDefReturnDate,
        $global:FieldDefBudgetApprovalStatus, $global:FieldDefBudgetApprovalTimeStamp, 
        $global:FieldDefGSSAprovalStatus, $global:FieldDefGSSApprovalTimestamp, $global:FieldDefAdditionalStaffMember

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListTARRequests
}

function EnsureTARDrafts() 
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field $web.Url -FieldDef $global:FieldDefRequester -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTraveller -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefLineManager -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefSelectedEmergencyContacts -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTypeOfTravel -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARVisaRequired -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARVisaNumber -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefPhotoID -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefMedicalEmergencyCard -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefMedicalProviderName -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefPolicyNumber -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARReadPDI -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARUsaidFunds -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARAppropriateVaccination -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTravelAdvances -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefGSSTraining -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefGSSTrainingDate -ListContext $global:ListTARRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARPurposeOfTravel -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARApprovedByDirector -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARAppropriateEmergencyContacts -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefDestinations -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARBudgetSession -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTAROtherEstimatedCosts -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARBudgetCodes -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARAdditionalInformation -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTravelCoordinator -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARBudgetApprover -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefInformationRead -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARLondonOfficeLocation -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefRequiresGssApproval -ListContext $global:ListTARDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefAdditionalStaffMember -ListContext $global:ListTARDrafts.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefTARDrafts -FieldDefs $global:FieldDefRequester, $global:FieldDefTARTraveller, $global:FieldDefLineManager,
        $global:FieldDefSelectedEmergencyContacts, $global:FieldDefTARTypeOfTravel, $global:FieldDefTARVisaRequired, $global:FieldDefTARVisaNumber, $global:FieldDefPhotoID, 
        $global:FieldDefMedicalEmergencyCard, $global:FieldDefMedicalProviderName, $global:FieldDefPolicyNumber,
        $global:FieldDefTARReadPDI, $global:FieldDefTARUsaidFunds, $global:FieldDefTARAppropriateVaccination, $global:FieldDefTARTravelAdvances,
        $global:FieldDefGSSTraining, $global:FieldDefGSSTrainingDate, $global:FieldDefTARPurposeOfTravel, $global:FieldDefTARApprovedByDirector, $global:FieldDefTARAppropriateEmergencyContacts,
        $global:FieldDefDestinations, $global:FieldDefTARBudgetSession, $global:FieldDefTAROtherEstimatedCosts, $global:FieldDefTARBudgetCodes,
        $global:FieldDefTARAdditionalInformation, $global:FieldDefTARTravelCoordinator, $global:FieldDefTARBudgetApprover, $global:FieldDefInformationRead, 
        $global:FieldDefTARLondonOfficeLocation, $global:FieldDefRequiresGssApproval, $global:FieldDefAdditionalStaffMember

    Configure-ContentTypeNonRequiredFields -Web $web -ContentTypeName $global:CTDefTARDrafts.Name -FieldNames @($global:FieldDefTARTraveller.InternalName, $global:FieldDefLineManager.InternalName, 
        $global:FieldDefSelectedEmergencyContacts.InternalName, $global:FieldDefTARTypeOfTravel.InternalName, $global:FieldDefTARVisaRequired.InternalName, $global:FieldDefPhotoID.InternalName, 
        $global:FieldDefMedicalEmergencyCard.InternalName, $global:FieldDefMedicalProviderName.InternalName, $global:FieldDefPolicyNumber.InternalName,
        $global:FieldDefTARReadPDI.InternalName, $global:FieldDefTARAppropriateVaccination.InternalName, $global:FieldDefTARTravelAdvances.InternalName,
        $global:FieldDefGSSTraining.InternalName, $global:FieldDefGSSTrainingDate.InternalName, $global:FieldDefTARPurposeOfTravel.InternalName, 
        $global:FieldDefTARApprovedByDirector.InternalName, $global:FieldDefTARAppropriateEmergencyContacts.InternalName,
        $global:FieldDefDestinations.InternalName, $global:FieldDefTARBudgetSession.InternalName, $global:FieldDefTAROtherEstimatedCosts.InternalName, $global:FieldDefTARBudgetCodes.InternalName,
        $global:FieldDefTARAdditionalInformation.InternalName, $global:FieldDefTARTravelCoordinator.InternalName, $global:FieldDefTARBudgetApprover.InternalName, $global:FieldDefInformationRead.InternalName,
        $global:FieldDefTARLondonOfficeLocation.InternalName, $global:FieldDefTARVisaNumber.InternalName, $global:FieldDefTARUsaidFunds.InternalName);

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListTARDrafts
}

function EnsureEIFRequests() 
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field $web.Url -FieldDef $global:FieldDefRequester -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFStaffResponsibleForGuest -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFFirstName -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFLastName -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFContactNumber -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFDateOfBirth -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFPassportNumber -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFPassportCountry -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFCountryOfOrigin -ListContext $global:ListEIFRequests.Title -webContext $web.ID 
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFVisaNumbers -ListContext $global:ListCountries.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFEmergencyContactName -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFEmergencyContactRelationship -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFEmergencyContactEmail -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFEmergencyContactHomePhone -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFEmergencyContactMobilePhone -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefDestinations -ListContext $global:ListEIFRequests.Title -webContext $web.ID 
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFTravelRouteDetails -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFMedicalConditions -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFBloodType -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFInsurancePolicyNumber -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFInsuranceCompany -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFInsuranceCompanyPhone -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFInsuranceContact -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFAdditionalComments -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefInformationRead -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefDepartureDate -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefReturnDate -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFTarId -ListContext $global:ListEIFRequests.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefAdditionalStaffMember -ListContext $global:ListEIFRequests.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefEIFRequests -FieldDefs $global:FieldDefRequester, $global:FieldDefEIFStaffResponsibleForGuest, $global:FieldDefEIFFirstName, 
        $global:FieldDefEIFLastName, $global:FieldDefEIFContactNumber, $global:FieldDefEIFDateOfBirth, $global:FieldDefEIFPassportNumber, 
        $global:FieldDefEIFPassportCountry, $global:FieldDefEIFCountryOfOrigin, $global:FieldDefEIFVisaNumbers, $global:FieldDefDestinations, 
        $global:FieldDefEIFEmergencyContactName, $global:FieldDefEIFEmergencyContactRelationship, $global:FieldDefEIFEmergencyContactEmail,
        $global:FieldDefEIFEmergencyContactHomePhone, $global:FieldDefEIFEmergencyContactMobilePhone,
        $global:FieldDefEIFTravelRouteDetails, $global:FieldDefEIFMedicalConditions, $global:FieldDefEIFBloodType, 
        $global:FieldDefEIFInsurancePolicyNumber, $global:FieldDefEIFInsuranceCompany, $global:FieldDefEIFInsuranceCompanyPhone, $global:FieldDefEIFInsuranceContact,
        $global:FieldDefEIFAdditionalComments, $global:FieldDefInformationRead, $global:FieldDefDepartureDate, $global:FieldDefReturnDate, $global:FieldDefEIFTarId,
        $global:FieldDefAdditionalStaffMember

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListEIFRequests
}

function EnsureEIFDrafts()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field $web.Url -FieldDef $global:FieldDefRequester -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFStaffResponsibleForGuest -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFFirstName -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFLastName -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFContactNumber -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFDateOfBirth -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFPassportNumber -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFPassportCountry -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFCountryOfOrigin -ListContext $global:ListEIFDrafts.Title -webContext $web.ID 
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFVisaNumbers -ListContext $global:ListCountries.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFEmergencyContactName -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFEmergencyContactRelationship -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFEmergencyContactEmail -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFEmergencyContactHomePhone -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFEmergencyContactMobilePhone -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefDestinations -ListContext $global:ListEIFDrafts.Title -webContext $web.ID 
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFTravelRouteDetails -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFMedicalConditions -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFBloodType -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFInsurancePolicyNumber -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFInsuranceCompany -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFInsuranceCompanyPhone -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFInsuranceContact -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFAdditionalComments -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefInformationRead -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefEIFTarId -ListContext $global:ListEIFDrafts.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefAdditionalStaffMember -ListContext $global:ListEIFDrafts.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefEIFDrafts -FieldDefs $global:FieldDefRequester, $global:FieldDefEIFStaffResponsibleForGuest, $global:FieldDefEIFFirstName, 
        $global:FieldDefEIFLastName, $global:FieldDefEIFContactNumber, $global:FieldDefEIFDateOfBirth, $global:FieldDefEIFPassportNumber, 
        $global:FieldDefEIFPassportCountry, $global:FieldDefEIFCountryOfOrigin, $global:FieldDefEIFVisaNumbers, $global:FieldDefDestinations, 
        $global:FieldDefEIFEmergencyContactName, $global:FieldDefEIFEmergencyContactRelationship, $global:FieldDefEIFEmergencyContactEmail,
        $global:FieldDefEIFEmergencyContactHomePhone, $global:FieldDefEIFEmergencyContactMobilePhone,
        $global:FieldDefEIFTravelRouteDetails, $global:FieldDefEIFMedicalConditions, $global:FieldDefEIFBloodType, 
        $global:FieldDefEIFInsurancePolicyNumber, $global:FieldDefEIFInsuranceCompany, $global:FieldDefEIFInsuranceCompanyPhone, $global:FieldDefEIFInsuranceContact,
        $global:FieldDefEIFAdditionalComments, $global:FieldDefInformationRead, $global:FieldDefEIFTarId, $global:FieldDefAdditionalStaffMember

    Configure-ContentTypeNonRequiredFields -Web $web -ContentTypeName $global:CTDefEIFDrafts.Name -FieldNames @($global:FieldDefEIFStaffResponsibleForGuest.InternalName, $global:FieldDefEIFFirstName.InternalName, 
        $global:FieldDefEIFLastName.InternalName, $global:FieldDefEIFContactNumber.InternalName, $global:FieldDefEIFDateOfBirth.InternalName, $global:FieldDefEIFPassportNumber.InternalName, 
        $global:FieldDefEIFPassportCountry.InternalName, $global:FieldDefEIFCountryOfOrigin.InternalName, $global:FieldDefEIFVisaNumbers.InternalName, $global:FieldDefDestinations.InternalName, 
        $global:FieldDefEIFEmergencyContactName.InternalName, $global:FieldDefEIFEmergencyContactRelationship.InternalName, $global:FieldDefEIFEmergencyContactEmail.InternalName,
        $global:FieldDefEIFEmergencyContactHomePhone.InternalName, $global:FieldDefEIFEmergencyContactMobilePhone.InternalName,
        $global:FieldDefEIFTravelRouteDetails.InternalName, $global:FieldDefEIFMedicalConditions.InternalName, $global:FieldDefEIFBloodType.InternalName, 
        $global:FieldDefEIFInsurancePolicyNumber.InternalName, $global:FieldDefEIFInsuranceCompany.InternalName, $global:FieldDefEIFInsuranceCompanyPhone.InternalName, 
        $global:FieldDefEIFInsuranceContact.InternalName, $global:FieldDefEIFAdditionalComments.InternalName, 
        $global:FieldDefInformationRead.InternalName, $global:FieldDefEIFTarId.InternalName, $global:FieldDefAdditionalStaffMember.InternalName);

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListEIFDrafts
}

function EnsureTARSettings()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field $web.Url -FieldDef $global:FieldDefSettingValue -ListContext $global:ListTARSettings.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefSettingUsedIn -ListContext $global:ListTARSettings.Title -webContext $web.ID
    Ensure-Field $web.Url -FieldDef $global:FieldDefSettingType -ListContext $global:ListTARSettings.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefTARSettings -FieldDefs $global:FieldDefSettingValue, $global:FieldDefSettingUsedIn, $global:FieldDefSettingType

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListTARSettings
}

#endregion

#region Workflows Storage

function EnsureWorkflowTasks()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web,
    [string]$ListName,
    [string]$Description
    )

    #$tasksTemplate = $web.ListTemplates | Where { $_.Name -eq $global:TasksListTemplate }

    #$web.Lists.Add($ListName, $Description, $tasksTemplate);

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListWorkflowTasks
}

function EnsureWorkflowHistory()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #Ensure-ContentType -Url $web.Url -CTDef $global:CTDefWorkflowHistory

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListWorkflowHistory
}

function EnsureEmailTemplates()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefEmailSubject -ListContext $global:ListTAREmailTemplates.Title -webContext $web.ID
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefEmailContent -ListContext $global:ListTAREmailTemplates.Title -webContext $web.ID

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefEmailTemplates -FieldDefs $global:FieldDefEmailSubject, $global:FieldDefEmailContent

    Ensure-ListFromDefinition -Web $web.Url -ListDef $global:ListTAREmailTemplates
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