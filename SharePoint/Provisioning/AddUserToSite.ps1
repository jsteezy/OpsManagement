Param(
    [string]$WebURL = $(throw "Web URL not provided."),
    [string]$UserLoginName = $(throw "User login name not provided."),
    [string]$DelegatedUserLoginName
)

function Get-UserProfileListName
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [int]$UserId
    )

    $userProfileLists = $web.Lists |  Where { $_.Title -like "User Profile*" } | Select -Property Title;

    $upperBoundCollection = @();

    foreach ($list in $userProfileLists)
    {
        $results = $list.Title -split ' ';

        $upperBoundCollection += [int]($results[2]);
    }

    $upperBoundCollection = $upperBoundCollection | Sort-Object;

    foreach ($bound in $upperBoundCollection)
    {
        if ($UserId -le $bound)
        {
            return "User Profile $bound";
        }
    }
}

function CreateEntryInUserInformationList
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [string]$UserLoginName
    )

    $user = $Web.EnsureUser($UserLoginName);
    if ($user -eq $null)
    {
        Write-Host "Creating entry for user $UserLoginName failed..." -BackgroundColor Red
        return $null;
    }

    Write-Output $user;
}

function GenerateProfileForUser
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [Microsoft.SharePoint.SPUser]$User,
        [Microsoft.SharePoint.SPUser]$DelegatedUser
    )

    $userProfileListName = Get-UserProfileListName -Web $Web -UserId $User.ID;

    $userProfileList = $Web.Lists.TryGetList($userProfileListName);
    if ($UserProfileList -eq $null)
    {
        Write-Host "Cannot find list $UserprofileListName ..." -BackgroundColor Red
        return;
    }

    $newProfile = $userProfileList.AddItem();

    $newProfile['User ID'] = $User.ID;
    $newProfile['User Email'] = $User.Email;
    $newProfile['First Name'] = $User.DisplayName;
    $newProfile['Last Name'] = $User.DisplayName;
    $newProfile['Job Title'] = 'NA';
    $newProfile['Department'] = 'NA';
    $newProfile['Office Location'] = 'NA';
    $newProfile['Emergency Contacts'] = '[]';
    $newProfile['Photo ID'] = 'NO';
    $newProfile['Medical Emergency Card'] = 'NO';
    $newProfile['Medical Provider Name'] = 'NA';
    $newProfile['Policy Number'] = 'NA';
    $newProfile['GSS Training'] = 'NO';
    $newProfile['User Language'] = 'en';
    $newProfile['Expenses Codes'] = '[]';
    $newProfile['Who can access the profile'] = $DelegatedUser;

    $newProfile.Update();
}

function UpdateDelegateUserProfile
{
    [CmdletBinding()]
    Param(
        [Microsoft.SharePoint.SPWeb]$Web,
        [Microsoft.SharePoint.SPUser]$User,
        [Microsoft.SharePoint.SPUser]$HasAccessToUser
    )

    $userProfileListName = Get-UserProfileListName -Web $Web -UserId $User.ID;

    $userProfileList = $Web.Lists.TryGetList($userProfileListName);
    if ($UserProfileList -eq $null)
    {
        Write-Host "Cannot find list $UserprofileListName ..." -BackgroundColor Red
        return;
    }

    $query = New-Object Microsoft.SharePoint.SPQuery;
    $query.RowLimit = 1;
    $query.Query = "<Where>
                        <Eq>
                            <FieldRef Name='TAR_UserId' />
                            <Value Type='Number'>$($User.ID)</Value>
                        </Eq>
                    </Where>";

    $items = $userProfileList.GetItems($query);

    if ($items.Count -ge 1)
    {
        $profile = $items[0];

        [Microsoft.SharePoint.SPFieldUserValueCollection]$userLookupCollection = $profile['Has access to user profiles'];

        if ($userLookupCollection -eq $null)
        {
            $userLookupCollection = New-Object Microsoft.SharePoint.SPFieldUserValueCollection
        }

        $userLookupCollection.Add((New-Object Microsoft.SharePoint.SPFieldUserValue($Web, $HasAccessToUser.ID, $HasAccessToUser.LoginName)));

        $profile['Has access to user profiles'] = $userLookupCollection;

        $profile.Update();
    }
    else 
    {
        Write-Host "Profile for user $User not found..." -BackgroundColor Red;
    }
}

Add-PSSnapin Microsoft.SharePoint.Powershell;

$web = Get-SPWeb $WebURL;

$user = CreateEntryInUserInformationList -Web $web -UserLoginName $UserLoginName;

$delegatedUser = CreateEntryInUserInformationList -Web $web -UserLoginName $DelegatedUserLoginName;

GenerateProfileForUser -Web $web -User $user -DelegatedUser $delegatedUser

UpdateDelegateUserProfile -Web $web -User $delegatedUser -HasAccessToUser $user

