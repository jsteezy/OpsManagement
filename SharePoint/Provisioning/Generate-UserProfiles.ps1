Param(
    [int]$StartIndex = $(throw "Start index not specified"),
    [int]$Count = $(throw "User Profiles count not specified")
)

. "$($PSScriptRoot)\Config.ps1"
. "$($PSScriptRoot)\SP-HelperFunctions.ps1"
. "$($PSScriptRoot)\DataModel-Definitions.ps1"

Add-PSSnapin Microsoft.SharePoint.Powershell

function Ensure-UserProfile
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$web
    )

    #region FIELDS

    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileId 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileEmail 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileFirstName 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileLastName 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileJobTitle 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileDepartment 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileOfficeLocation
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefLineManager
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefEmergencyContacts 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefPhotoID 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefMedicalEmergencyCard 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefMedicalProviderName 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefPolicyNumber 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefGSSTraining 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefGSSTrainingDate 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileLanguage 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileExpensesCodes 
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileOthersAccess
    Ensure-Field -Url $web.Url -FieldDef $global:FieldDefUserProfileHasAccess

    #endregion

    Ensure-ContentType -Url $web.Url -CTDef $global:CTDefUserProfile -FieldDefs $global:FieldDefUserProfileId, $global:FieldDefUserProfileEmail, $global:FieldDefUserProfileFirstName, 
        $global:FieldDefUserProfileLastName, $global:FieldDefUserProfileJobTitle, $global:FieldDefUserProfileDepartment, $global:FieldDefUserProfileOfficeLocation,
        $global:FieldDefLineManager, $global:FieldDefEmergencyContacts, $global:FieldDefPhotoID, 
        $global:FieldDefMedicalEmergencyCard, $global:FieldDefMedicalProviderName, $global:FieldDefPolicyNumber,
        $global:FieldDefGSSTraining, $global:FieldDefGSSTrainingDate, $global:FieldDefUserProfileLanguage, $global:FieldDefUserProfileExpensesCodes,
        $global:FieldDefUserProfileOthersAccess, $global:FieldDefUserProfileHasAccess

    Configure-ContentTypeNonRequiredFields -Web $web -ContentTypeName $global:CTDefUserProfile.Name -FieldNames @($global:FieldDefGSSTrainingDate.InternalName, $global:FieldDefMedicalProviderName.InternalName,
        $global:FieldDefMedicalEmergencyCard.InternalName);
}

function Create-UserProfile
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [string]$ListName,
    [string]$ListTitle
    )

    $listDefinition = New-ListDefinition -ListTitle $ListTitle -ListUrl $ListName -Description "User Profile list for TAR" -Template "Custom List" -ContentTypes @($global:CTDefUserProfile.Name);

    Ensure-ListFromDefinition -Web $web.Url -ListDef $listDefinition

    HideTitleField -Web $Web -ListName $ListTitle

    Hide-Fields -Web $Web -ListName $ListTitle -Fields @("Emergency Contacts", "Medical Emergency Card", "Medical Provider Name", "Policy Number", "Expenses Codes", "Has access to user profiles", "Line Manager")

    Write-Host "List $ListTitle created..."

    SetListPermissionForGroup -Web $Web -ListName $ListTitle -GroupName $global:TARAllUsersGroupName -Role "Contribute"
}

function Create-UserProfileLists
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [int]$StartIndex,
    [int]$Count
    )

    Ensure-UserProfile -Web $Web

    for ($i = 0; $i -lt $Count; $i++) 
    {
        $listUpperLimit = $StartIndex + ($i + 1) * $global:ListSize;
        $listName = $global:UserProfileListName + $listUpperLimit;
        $listTitle = $global:UserProfileListTitle + " " + $listUpperLimit;

        Create-UserProfile -Web $Web -ListName $listName -ListTitle $listTitle
    }
}

$global:ListSize = 4000;

$web = Get-SPWeb $global:spSiteUrl

Create-UserProfileLists -Web $web -StartIndex $StartIndex -Count $Count

$web.Update();
