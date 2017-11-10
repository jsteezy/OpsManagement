Param(
    [int]$StartYear = $(throw "Starting year not specified"),
    [int]$Count = $(throw "User Profiles count not specified")
)

. "$($PSScriptRoot)\Config.ps1"
. "$($PSScriptRoot)\SP-HelperFunctions.ps1"
. "$($PSScriptRoot)\DataModel-Definitions.ps1"

Add-PSSnapin Microsoft.SharePoint.Powershell

function Ensure-TARRequestsArchive
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field $web.Url -FieldDef $global:FieldDefRequester 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTraveller 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARLineManager 
    Ensure-Field $web.Url -FieldDef $global:FieldDefSelectedEmergencyContacts 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTypeOfTravel 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARVisaRequired 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARVisaNumber 
    Ensure-Field $web.Url -FieldDef $global:FieldDefPhotoID 
    Ensure-Field $web.Url -FieldDef $global:FieldDefMedicalEmergencyCard 
    Ensure-Field $web.Url -FieldDef $global:FieldDefMedicalProviderName 
    Ensure-Field $web.Url -FieldDef $global:FieldDefPolicyNumber 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARReadPDI 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARUsaidFunds 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARAppropriateVaccination 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTravelAdvances 
    Ensure-Field $web.Url -FieldDef $global:FieldDefGSSTraining 
    Ensure-Field $web.Url -FieldDef $global:FieldDefGSSTrainingDate 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARPurposeOfTravel 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARApprovedByDirector 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARAppropriateEmergencyContacts 
    Ensure-Field $web.Url -FieldDef $global:FieldDefDestinations 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARBudgetSession 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTAROtherEstimatedCosts 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARBudgetCodes 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARAdditionalInformation 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARTravelCoordinator 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARBudgetApprover 
    Ensure-Field $web.Url -FieldDef $global:FieldDefInformationRead 
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARLondonOfficeLocation 
    Ensure-Field $web.Url -FieldDef $global:FieldDefRequiresGssApproval 
    Ensure-Field $web.Url -FieldDef $global:FieldDefDepartureDate 
    Ensure-Field $web.Url -FieldDef $global:FieldDefReturnDate 
    Ensure-Field $web.Url -FieldDef $global:FieldDefBudgetApprovalStatus 
    Ensure-Field $web.Url -FieldDef $global:FieldDefBudgetApprovalTimeStamp 
    Ensure-Field $web.Url -FieldDef $global:FieldDefGSSAprovalStatus 
    Ensure-Field $web.Url -FieldDef $global:FieldDefGSSApprovalTimestamp 
    Ensure-Field $web.Url -FieldDef $global:FieldDefAdditionalStaffMember
    Ensure-Field $web.Url -FieldDef $global:FieldDefTARCreatedDate

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefTARArchiveRequests -FieldDefs $global:FieldDefRequester, $global:FieldDefTARTraveller, $global:FieldDefTARLineManager,
        $global:FieldDefSelectedEmergencyContacts, $global:FieldDefTARTypeOfTravel, $global:FieldDefTARVisaRequired, $global:FieldDefTARVisaNumber, $global:FieldDefPhotoID, 
        $global:FieldDefMedicalEmergencyCard, $global:FieldDefMedicalProviderName, $global:FieldDefPolicyNumber,
        $global:FieldDefTARReadPDI, $global:FieldDefTARUsaidFunds, $global:FieldDefTARAppropriateVaccination, $global:FieldDefTARTravelAdvances,
        $global:FieldDefGSSTraining, $global:FieldDefGSSTrainingDate, $global:FieldDefTARPurposeOfTravel, $global:FieldDefTARApprovedByDirector, $global:FieldDefTARAppropriateEmergencyContacts,
        $global:FieldDefDestinations, $global:FieldDefTARBudgetSession, $global:FieldDefTAROtherEstimatedCosts, $global:FieldDefTARBudgetCodes,
        $global:FieldDefTARAdditionalInformation, $global:FieldDefTARTravelCoordinator, $global:FieldDefTARBudgetApprover, $global:FieldDefInformationRead, 
        $global:FieldDefTARLondonOfficeLocation, $global:FieldDefRequiresGssApproval, $global:FieldDefDepartureDate, $global:FieldDefReturnDate,
        $global:FieldDefBudgetApprovalStatus, $global:FieldDefBudgetApprovalTimeStamp, 
        $global:FieldDefGSSAprovalStatus, $global:FieldDefGSSApprovalTimestamp, $global:FieldDefAdditionalStaffMember, $global:FieldDefTARCreatedDate
}

function Create-TARRequestsArchive
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [string]$ListName,
    [string]$ListTitle
    )

    $listDefinition = New-ListDefinition -ListTitle $ListTitle -ListUrl $ListName -Description "TAR Requests Archive list for TAR" -Template "Custom List" -ContentTypes @($global:CTDefTARArchiveRequests.Name);

    Ensure-ListFromDefinition -Web $web.Url -ListDef $listDefinition

    Write-Host "List $ListTitle created..."
}

function Create-TARRequestsArchiveLists
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [int]$StartYear,
    [int]$Count
    )

    Ensure-TARRequestsArchive -Web $Web

    for ($i = 0; $i -lt $Count; $i++) 
    {
        $year = $StartYear + $i;
        $listName = $global:TARRequestsArchiveListName + $year;
        $listTitle = $global:TARRequestsArchiveListTitle + " " + $year;

        Create-TARRequestsArchive -Web $Web -ListName $listName -ListTitle $listTitle
    }
}

$global:TARRequestsArchiveListName = "TARRequestsArchive";
$global:TARRequestsArchiveListTitle = "TAR Requests Archive";

$web = Get-SPWeb $global:spSiteUrl

Create-TARRequestsArchiveLists -Web $web -StartYear $StartYear -Count $Count

$web.Update();