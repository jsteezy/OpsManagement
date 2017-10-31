#Constants
$global:CTNameMasterPage = "Master Page"
$global:CTNamePageLayout = "Page Layout"

function global:Log {
  param(
    [parameter(Mandatory=$true,
    ValueFromPipeline=$true, Position=0, ValueFromRemainingArguments=$true)]
    [String[]]
    [ValidateNotNullOrEmpty()]
    $Msg,
    [String]
    [ValidateSet("Error", "Warning", "Info", "Normal", "Success")]
    $Level = "Normal"
  ) 
              

	if ($Level -eq "Warning") {
        $color = "Yellow";
    }
    if ($Level -eq "Error") {
        $color = "Red";
    }
    if($Level -eq "Normal") {
        $color = "White";
    }
    if($Level -eq "Info") {
        $color = "Cyan";
    }
    if($Level -eq "Success") {
        $color = "Green";
    }
    
    Write-Host $Msg -ForegroundColor $color;
}

function global:Generate-ListUrl ([string]$listTitle)
{
    return $listTitle.Replace(" ","");
}

function global:HideTitleField()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [Parameter(Mandatory=$true)]
    [string]$ListName
    )

    $list = $Web.Lists[$ListName];
    if ($list -ne $null)
    {
        $titleColumn = $list.Fields["Title"];
        $titleColumn.Required = $false;
        $titleColumn.Hidden = $true;

        $titleColumn.Update();
        $list.Update();
    }
}

function global:Hide-Fields
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [Parameter(Mandatory=$true)]
    [string]$ListName,
    [string[]]$Fields
    )

    $list = $Web.Lists[$ListName];
    if ($list -ne $null)
    {
        foreach ($fieldName in $Fields) 
        {
            $fieldColumn = $list.Fields[$fieldName]
            if ($fieldColumn -ne $null) 
            {
                $fieldColumn.ShowInEditForm = $false;
                $fieldColumn.ShowInDisplayForm = $false;
                $fieldColumn.ShowInVersionHistory = $false;
                $fieldColumn.ShowInViewForms = $false;

                $fieldColumn.Update();
            }
        }

        $list.Update();
    }
}

function global:Ensure-List
{
<#
.Synopsis
    Use New-SPList to create a new SharePoint List or Library.
.Description
    This advanced PowerShell function uses the Add method of a SPWeb object to create new lists and libraries in a SharePoint Web
    specified in the -Web parameter.
.Example
    C:\PS>New-SPList -Web http://intranet -ListTitle "My Documents" -ListUrl "MyDocuments" -Description "This is my library" -Template "Document Library"
    This example creates a standard Document Library in the http://intranet site.
.Example
    C:\PS>New-SPList -Web http://intranet -ListTitle "My Announcements" -ListUrl "MyAnnouncements" -Description "These are company-wide announcements." -Template "Announcements"
    This example creates an Announcements list in the http://intranet site.
.Notes
    You must use the 'friendly' name for the type of list or library.  To retrieve the available Library Templates, use Get-SPListTemplates.
.Link
 
http://www.iccblogs.com/blogs/rdennis
 
 
http://twitter.com/SharePointRyan
 
.Inputs
    None
.Outputs
    None
#>    
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string]$Web,
    [Parameter(Mandatory=$true)]
    [string]$ListTitle,
    [Parameter(Mandatory=$true)]
    [string]$ListUrl,
    [Parameter(Mandatory=$false)]
    [string]$Description,
    [Parameter(Mandatory=$true)]
    [string]$Template,
    [Parameter(Mandatory=$true)]
    [bool]$EnableContentTypes = $false
    )

    Write-Host "Ensuring list" $ListTitle "in web" $Web "with template" $Template;
    Start-SPAssignment -Global;
    $SPWeb = Get-SPWeb -Identity $Web;
    $list = $SPWeb.Lists.TryGetList($ListTitle);
    if($list -eq $null)
    {            
        Write-Host "List doesnt exist... creating";
        $listTemplate = $SPWeb.ListTemplates[$Template]; 
        $Id = $SPWeb.Lists.Add($ListUrl,$Description,$listTemplate);
        $list = $SPWeb.Lists[$ListUrl];
        $list.Title = $ListTitle;
        $list.ContentTypesEnabled = $EnableContentTypes;
        [void]($list.Update());
        Write-Host "List created";
    }
    else
    {
        Write-Host "List exists... skipping";
    }
    
    $SPWeb.Dispose()
    Stop-SPAssignment -Global;

    return $list;
}

function global:Ensure-ListField
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string]$Web,
    [Parameter(Mandatory=$true)]
    $ListDef,
    [Parameter(Mandatory=$true)]
    $FieldDef    
    )

    $ListTitle = $ListDef.Title;
    Write-Host "Ensuring field" $FieldDef.DisplayName "in list" $ListTitle;
    Start-SPAssignment -Global;
    $SPWeb = Get-SPWeb -Identity $Web;
    $list = $SPWeb.Lists.TryGetList($ListTitle);
    if($list -eq $null)
    {            
        Write-Host "List doesnt exist... ensure list is created first" -ForegroundColor Yellow;        
    }
    else
    {
        
        if($list.Fields.ContainsFieldWithStaticName($FieldDef.InternalName))
        {
            Write-Host "Field already exists in list";        
        }
        else{
            $field = $SPWeb.Fields.GetFieldByInternalName($FieldDef.InternalName);
            $list.Fields.Add($field);
            $list.Update();
        }
    }
    
    $SPWeb.Dispose()
    Stop-SPAssignment -Global;
}

function global:Ensure-ListFromDefinition
{
<#
.Synopsis
    Creates a new SP-List from a ListDefinition created by New-ListDefinition
.Description    
#>    
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string]$Web,
    [Parameter(Mandatory=$true)]
    $ListDef    
    )

	$list = Ensure-List -Web $Web -ListTitle $ListDef.Title -ListUrl $ListDef.ListUrl -Description $ListDef.Description -Template $ListDef.Template -EnableContentTypes $false;
	$list.EnableFolderCreation = $ListDef.AllowFolders;

    $enableCT = $ListDef.ContentTypes.Count -gt 0;

	# Ensure content types on list
    if($enableCT)
    {
		Configure-ListContentTypes $list $ListDef.ContentTypes -RemoveExisting;
    }

	$list.Update();
	return $list;
}

function global:Ensure-Field($Url, $FieldDef, [switch] $Force, [string]$ListContext, [string]$webContext)
{

	$internalName = $FieldDef.InternalName;
    $web = Get-SPWeb -Identity $Url;

    if($listContext -ne $null)
    {
        $ctxList = $web.Lists.TryGetList($listContext);
        if($ctxList -ne $null)
        {
            Log "Update list context with ID: $($ctxList.ID)";
            $FieldDef.FieldXml = $FieldDef.FieldXml.Replace("{{ListContext}}","$($ctxList.ID)");        
        }
    }

    if($webContext -ne $null)
    {
        Log "Update web context with ID: $($webContext)";
        $FieldDef.FieldXml = $FieldDef.FieldXml.Replace("{{WebContext}}","$($webContext)");        
    }
            
    $xml = [xml]($FieldDef.FieldXml);

    Write-Host "Ensuring Field" $FieldDef.DisplayName "on web:" $web.Url;
    $exists = $Web.Fields.ContainsFieldWithStaticName($internalName);

    if(!$Web.Fields.ContainsFieldWithStaticName($internalName))
    {
		if (($internalName.Length -gt 32) -and (!$Force)) {
			Write-Error "This field name would be truncated in the Search Schema. Use the Force option to override.`r`n`tThe field will not be created.";
			return;
		}

        Write-Host "Field not found... creating...";
        $web.Fields.AddFieldAsXml($FieldDef.FieldXml);
    }
    else
    {
        Write-Host "Field exists... skipping...";
		# TODO: Update existing field definition from $FieldDef
		# If Choice, ensure all choices, remove legacy choices
    }
}

function global:New-FieldDefinition ([string]$FieldXml)
{
    $xml = [xml]$FieldXml
    $properties = @{'DisplayName'=$xml.Field.DisplayName;
                    'InternalName'=$xml.Field.StaticName;
                    'Type'=$xml.Field.Type;
                    'Id'=$xml.Field.Id;
                    'FieldXml'=$FieldXml};
    $fieldDef = New-Object PSObject -Property $properties;
    <#
	# Add-Member -InputObject $fieldDef -MemberType NoteProperty -Name Name -Value $DisplayName
    # Add-Member -InputObject $fieldDef -MemberType NoteProperty -Name Parent -Value $InternalName
    # Add-Member -InputObject $fieldDef -MemberType NoteProperty -Name Group -Value $Type
    # Add-Member -InputObject $fieldDef -MemberType NoteProperty -Name FieldXml -Value $FieldXml
	#>
    $fieldDef.pstypenames.insert(0,'FieldDefinition')
    return $fieldDef;

}

function global:New-ListDefinition ([string]$ListTitle, [string]$ListUrl, [string]$Description, [string]$Template, [string[]]$ContentTypes, [switch] $AllowFolders)
{    
    $properties = @{'Title'=$ListTitle;
                    'ListUrl'=$ListUrl;
                    'Template'=$Template;
                    'Description'=$Description;
                    'ContentTypes'=$ContentTypes;
					'AllowFolders'=$AllowFolders}
    $listDef = New-Object PSObject -Property $properties;
    
    $listDef.pstypenames.insert(0,'ListDefinition')
    return $listDef;
}

function global:New-ContentTypeDefinition ([string] $ID, [string] $Name, [string] $Parent, [string] $Group, [string] $Description)
{    
    $properties = @{'ID'=$ID;
					'Name'=$Name;
                    'Parent'=$Parent;
                    'Group'=$Group;
                    'Description'=$Description}
    $ctDef = New-Object PSObject -Property $properties;
    
    $ctDef.pstypenames.insert(0,'ContentTypeDefinition')
    return $ctDef;
}

function global:Configure-ListContentTypes([Microsoft.SharePoint.SPList] $List, $ContentTypes, [switch] $RemoveExisting, [switch] $RemoveFolderContentType)
{
    if($list -ne $null)
    {
        Write-Host "Configure List Content Types for" $list.Title
        Write-Host "ContentTypes:" $ContentTypes 
        if(!$list.ContentTypesEnabled)
        {
            Write-Host "Enabling content types on list..."
            $list.ContentTypesEnabled = $true;
        }

        Log "`tEnsure content types on list..."
        
        $existingContentTypes = $list.ContentTypes | ForEach-Object { $_.Name };
		$wantedContentTypes = $ContentTypes;
		$contentTypesToRemove = @();
		$contentTypesToAdd = @();
		
		foreach($existingContentType in $existingContentTypes) {
			if ($wantedContentTypes -contains $existingContentType) {
				continue;
			}

			$contentTypesToRemove += $existingContentType;
		}

		foreach($wantedContentType in $wantedContentTypes) {
			if ($existingContentTypes -contains $wantedContentType) {
				continue;
			}

			$contentTypesToAdd += $wantedContentType;
		}

		foreach($contentType in $contentTypesToAdd)
		{
			try
			{
				Log "`tAdding Content Type: $contentType" -Level Info;
				$siteContentType = $list.ParentWeb.AvailableContentTypes[$contentType];
				[void] $list.ContentTypes.Add($siteContentType);
			}
			catch [System.Exception]
			{
				Log $_ -Level Error;
			}
		}

		if ($RemoveExisting)
		{
			foreach($contentType in $contentTypesToRemove)
			{
				try
				{
					if ($contentType -eq "Folder" -and (-not $RemoveFolderContentType)) {
						continue;
					}

					Log "`tRemoving Content Type: $contentType" -Level Info;
					$contentType = $list.ContentTypes[$contentType];
					$contentType.Delete();
				}
				catch [System.Exception]
				{
					Log $_ -Level Error;
				}
			}
		}
        $list.Update() | Out-Null;
    }
}

function global:Ensure-ContentType($Url, $CTDef, $FieldDefs)
{

    Write-Host "Ensuring Content Type "$CTDef.Name" on web: "$Url;

    $web = Get-SPWeb -Identity $Url;
    $ct = $web.ContentTypes[$CTDef.Name];

    if($ct -eq $null)
    {
        Write-Host "Doesnt exist... creating...";

		$spContentType = $null;

		if ($CTDef.Parent -eq $null) {
	        $spContentType = new-object Microsoft.SharePoint.SPContentType($parentCt, $web.ContentTypes, $CTDef.Name);
		}
		else
		{
			$contentTypeId = $null;
			$parentCt = $web.AvailableContentTypes[$CTDef.Parent];
			
			if ($CTDef.ID -ne $null) {
				if ($CTDef.ID.StartsWith("0x")) {		<# Absolute ID #>
					$contentTypeId = new-object Microsoft.SharePoint.SPContentTypeId($CTDef.ID);
				}
				else {
					$contentTypeId = new-object Microsoft.SharePoint.SPContentTypeId("$($parentCt.Id.ToString())00$($CTDef.ID)");
				}

			    $spContentType = new-object Microsoft.SharePoint.SPContentType($contentTypeId, $web.ContentTypes, $CTDef.Name);
			}
			else
			{
				$spContentType = new-object Microsoft.SharePoint.SPContentType($parentCt, $web.ContentTypes, $CTDef.Name);
			}
		}

        $ct = $web.ContentTypes.Add($spContentType);
        Write-Host "Content type" $ct.Name "created.";
    }
    else
    {
        Write-Host "Content type exists... ";
    }
        
    $ct.Group = $CTDef.Group;
    $ct.Description = $CTDef.Description;
	$ct.Update();

    Write-Host "Ensure Field Links";

    foreach($fieldDef in $FieldDefs)
    {
        Write-Host "Ensure field link for field:" $fieldDef.DisplayName;
		$spFieldLink = $ct.FieldLinks[$fieldDef.InternalName];
        $siteField = $web.AvailableFields.GetFieldByInternalName($fieldDef.InternalName);
        
		if (!($spFieldLink))
        {
            Write-Host "Creating FieldLink for" $fieldDef.DisplayName;
            
            if($siteField -eq $null)
            {
                Write-Host "Site column not found:" $fieldDef.InternalName;
                continue;
            }
            $spFieldLink = New-Object Microsoft.SharePoint.SPFieldLink ($siteField);

            $ct.FieldLinks.Add($spFieldLink);
        }

        $spFieldLink.Required = $siteField.Required;
        $spFieldLink.Hidden = $siteField.Hidden;
    }

    $ct.Update($true);

    return $ct;
}

function global:Remove-AllLists
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [string[]]$ListNames
    )

    foreach ($listName in $ListNames) 
    {
        $list = $Web.Lists[$listName];
        if ($list -ne $null) 
        { 
            $list.AllowDeletion = $true;
            $list.Update();
            $list.Delete();
        }
    }

    $web.Update();
}

function global:Remove-AllContentTypes
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [string]$GroupName
    )

    $contentTypes = $Web.ContentTypes | Where { $_.Group -eq $GroupName };
    $contentTypes | foreach-object {
        Write-Warning "Removing Content Type $($_.Name)";
		$_.Delete(); 
    }
}

function global:Remove-AllSiteColumns
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [string]$GroupName
    )

    $fields = $Web.Fields | Where { $_.Group -eq $GroupName };
	$fields | foreach-object {
		Write-Warning "Removing Field $($_.Name)";
		$_.Delete(); 
	}
}

function global:Remove-AllFields
{
 param(
	[string] $Url
	,[string] $GroupName
 )

	$web = Get-SPWeb $Url;
	$rootWeb = $web.Site.RootWeb;

	$fields = $rootWeb.Fields | Where { $_.Group -eq $GroupName };
	$fields | foreach-object {
		Write-Warning "Removing Field $($_.Name)";
		$_.Delete(); 
	}
}

function global:Configure-ContentTypeRequiredFields
{
 param(
	[Parameter(Mandatory = $true)]
	[Microsoft.SharePoint.SPWeb] $Web
	,
	[Parameter(Mandatory = $true)]
	[string] $ContentTypeName
	,
	[Parameter(Mandatory = $true)]
	[string[]] $FieldNames
 )

	$contentType = $web.ContentTypes[$ContentTypeName];
	foreach($field in $fieldNames) 
	{
        Log "Configure required field: $($field)" -Level Normal
		$link = $contentType.FieldLinks[$field];
		$link.Required = $true;
	}

	$contentType.Update($true);
}

function global:Configure-ContentTypeNonRequiredFields
{
 param(
	[Parameter(Mandatory = $true)]
	[Microsoft.SharePoint.SPWeb] $Web
	,
	[Parameter(Mandatory = $true)]
	[string] $ContentTypeName
	,
	[Parameter(Mandatory = $true)]
	[string[]] $FieldNames
 )

	$contentType = $web.ContentTypes[$ContentTypeName];
	foreach($field in $fieldNames) 
	{
        Log "Configure required field: $($field)" -Level Normal
		$link = $contentType.FieldLinks[$field];
		$link.Required = $false;
	}

	$contentType.Update($true);
}

function global:Create-ListItemsFromXml {
<#
.Synopsis
    Creates a SP-List items from an input xml definition 
.Description    
#>    
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string]$Web,
    [Parameter(Mandatory=$true)]
    [string]$ListTitle,	
	[Parameter(Mandatory=$true)]
	[string]$XmlInput,
	[Parameter(Mandatory=$false)]
	[switch]$Overwrite
    )

    $spWeb = Get-SPWeb $Web
    $list = $spWeb.Lists.TryGetList($ListTitle);
    $allItems = $list.Items;
    if($list -ne $null)
    {    
	    Log "`nCreating list items in list $($ListTitle) on web $($Web)..." -Level Info;

        [xml]$itemsXML = Get-Content $($XmlInput);
        if ($itemsXML -eq $null) { 
            Log "Could not parse XmlInput..." -Level Error
            return; 
        }

        $itemsXML.ListItems.ListItem | ForEach-Object {

            $itemXml = $_;
            $title = $itemXml.Title;

            Log "`tEnsure list item: $($title)" -Level Normal

            $exists = $allItems | Where-Object { $_.Title -eq $title } | Select-Object -First 1

            if($exists)
			{
				if (!$Overwrite)
				{
					Log "`tItem exists.... skipping";
					return;
				}

				$exists.Delete();
			}

            Log "`tCreating...";
            $item = $list.Items.Add();
            $item["Title"] = $title;

            $itemMetadata = $itemXml.MetaData;

            if ($itemMetadata -ne $null) {
				$itemMetadata | gm -type Property | % {
                    $prop = $_;
					$propertyName = $prop.Name;
					$propertyValue = $itemMetadata.($propertyName);
					$listField = $list.Fields.GetField($propertyName);

					Write-Host "Setting $propertyName to $propertyValue";

					if ($listField.Type -eq "User" -and (![string]::IsNullOrWhiteSpace($propertyValue)))
					{
						$user = $spWeb.EnsureUser($propertyValue);
						$propertyValue = $user;
					}elseif($listfield.Type -eq "Lookup" -and (![string]::IsNullOrWhiteSpace($propertyValue)))
                    {
                        Log "Lookup value for $($propertyValue)";   
                        $listFieldLookup = [Microsoft.SharePoint.SPFieldLookup]$listField;
                        $listGuid = [GUID]$listFieldLookup.LookupList;
                        $site = $listField.ParentList.ParentWeb.Site;
                        $lookupWeb = [Microsoft.SharePoint.SPWeb]$site.OpenWeb($listFieldLookup.LookupWebId);
                        $lookupList = $lookupWeb.Lists[$listGuid];
                        $sourceItem = $lookupList.Items | Where-Object { $_.Title -eq $propertyValue } | Select-Object -First 1;
                        
                        if($sourceItem -ne $null)
                        {
                            $propertyValue = $sourceItem.ID;
                        }
                        else{
                            $propertyValue = $null;
                        }                        
                        
                        $lookupWeb.Dispose();
                    }

					$item[$propertyName] = $propertyValue;
				} | Where { $_ -is [Xml.XmlElement] };
			}
                                
            $item.Update();                
        }
    }

    $spWeb.Dispose();

	Log "`nCreating list items complete in list $($ListTitle) on web $($Web)..." -Level Info;
    
}

function New-SPPage{
<#
.Synopsis
    The New-SPPage function creates one or more Publishing Pages in a SharePoint Publishing Site.
.Description
    The New-SPPage function uses the PublishingSite and PublishingWeb objects to call the Add() method for provisioning of SharePoint Publishing Pages.
.Example
    C:\PS>New-SPPage -SiteUrl http://intranet `
    -PageTitle "My Page" `
    -PageUrl MyPage.aspx `
    -PageContent "This is my text." `
    -PageLayout "Article Page" `
    -CheckIn -Publish   
    This example creates a single page in the http://intranet site.
.Example
    C:\PS>New-SPPage -CreateFromXml -XmlInput "C:\Pages.xml" -Checkin -Publish
    This example creates pages based on an xml file with the following schema:
<?xml version="1.0" encoding="utf-8"?>
<Pages>
  <Page>
        <PageTitle>Page 1</PageTitle>
        <PageUrl>Page1.aspx</PageUrl>
        <PageContent>
        This is some text.
        This is another line of text.
        </PageContent>
        <PageLayout>Article Page</PageLayout>
  </Page> 
</Pages>
.Notes
    Name: New-SPPage
    Author: Ryan Dennis
    Last Edit: 7/25/2011
    Keywords: New-SPPage
.Link
    http://www.sharepointryan.com
    http://twitter.com/SharePointRyan
.Inputs
    None
.Outputs
    None
#Requires -Version 2.0
#>
[CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true)]
    [string]$WebUrl,
    [Parameter(Mandatory=$false)]
    [string]$PageTitle,
    [Parameter(Mandatory=$false)]
    [string]$PageUrl,
    [Parameter(Mandatory=$false)]
    [string]$PageContent,
    [Parameter(Mandatory=$false)]
    [string]$PageLayout,
    [Parameter(Mandatory=$false)]
    [switch]$CheckIn,
    [Parameter(Mandatory=$false)]
    [switch]$Publish,
    [Parameter(Mandatory=$false)]
    [switch]$CreateFromXml,
    [Parameter(Mandatory=$false)]
    [string]$XmlInput
    )
#Region CreateFromXml
if ($CreateFromXml) {
    # Read in list of pages from XML
    [xml]$pagesXML = Get-Content $($XmlInput)
    if ($pagesXML -eq $null) { return }
    # Get publishing web
    $site = New-Object Microsoft.SharePoint.SPSite($SiteUrl)
    $psite = New-Object Microsoft.SharePoint.Publishing.PublishingSite($site)
    $web = $site.OpenWeb()
    $pWeb = [Microsoft.SharePoint.Publishing.PublishingWeb]::GetPublishingWeb($web)
    # Loop through each page node to extract filename
    $pagesXML.Pages.Page | ForEach-Object {
        $PageTitle = [string]$_.PageTitle
        $PageUrl = [string]$_.PageUrl
        $PageLayout = [string]$_.PageLayout
        $PageContent = [string]$_.PageContent
        $ctype = $psite.ContentTypes[$PageLayout]
        $layouts = $psite.GetPageLayouts($ctype, $true)
        $layout = $layouts[0]
        Write-Host "Creating $($PageTitle)"
 
        # Create blank page
        $pages = $pWeb.GetPublishingPages($pWeb)
        $page = $pages.Add($PageUrl, $Layout)
        #$newPage = $pWeb.AddPublishingPage($PageUrl,$PageLayout)
        $page.Update()
 
        # Update the filename to the one specified in the XML
        $item = $page.ListItem
        $item["Title"] = $PageTitle;
        $item["Page Content"] = $PageContent;
        $item.Update()
        # Check-in and publish page
        if ($CheckIn){$item.File.CheckIn("")}
        if ($Publish){$item.File.Publish("");}
    } #End ForEach Loop
    # Dispose of the web
    $web.Dispose()
} #End CreateFromXml
#EndRegion CreateFromXml
#Region CreateSinglePage
else {
    Start-SPAssignment -Global
    $web = New-Object Microsoft.SharePoint.SPWeb($WebUrl)
    $psite = New-Object Microsoft.SharePoint.Publishing.PublishingWeb($web)
    $ctype = $psite.ContentTypes[$PageLayout]
    $layouts = $psite.GetPageLayouts($ctype, $true)
    $layout = $layouts[0]
    $web = $site.OpenWeb(); #Site.Rootweb
    $pweb = [Microsoft.SharePoint.Publishing.PublishingWeb]::GetPublishingWeb($web)
    $pages = $pweb.GetPublishingPages($pweb)
    $page = $pages.Add($PageUrl, $layout)
    $item = $page.ListItem
    Write-Host "Creating $($PageTitle)"
    $item["Title"] = $PageTitle;
    $item["Page Content"] = $PageContent;
    $item.Update() 
    if ($CheckIn){$item.File.CheckIn("")}
    if ($Publish){$item.File.Publish("")}
    $site.Dispose()
    $web.Dispose()
    Stop-SPAssignment -Global
    } #End single page from else
} #End function

function Ensure-PublishingFeatures
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true)]
    [string]$WebUrl)
 
    [void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Sharepoint.Publishing")
    [void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Sharepoint.Administration")

    $web = Get-SPWeb $WebUrl;
    $site = $web.Site;
        
    # First check if this is a publishing site collection
    if(![Microsoft.SharePoint.Publishing.PublishingSite]::IsPublishingSite($site))
    {
        Log -Level Warning "`tThe site collection at $($site.Url) is not a publishing site... activiting site collection publishing feature";
        $PublishingSiteFeature = Get-SPFeature -Identity PublishingSite
        Log "`tActivating " $PublishingSiteFeature.DisplayName " on "  $site.Url
        Enable-SPFeature $PublishingSitefeature -Url $site.Url #Enable the feature to the site collection
        Log "`tActivated " $PublishingSiteFeature.DisplayName " on "  $site.Url -Level Success
    }else { Log "`tConfirmed site collection features activated"; }

    if(![Microsoft.SharePoint.Publishing.PublishingWeb]::IsPublishingWeb($web))
    {
        Log -Level Warning "`tThe web at $($web.Url) is not a publishing web... activiting publishing features";
        $PublishingWebFeature = Get-SPFeature -Identity PublishingWeb
        Log "`tActivating " $PublishingWebFeature.DisplayName " on "  $web.Url
        Enable-SPFeature $PublishingWebFeature -Url $web.Url #Enable the feature to the site collection
        Log "`tActivated " $PublishingWebFeature.DisplayName " on "  $web.Url -Level Success

    }else { Log "`tConfirmed web features activated"; }  
    
    $web.Dispose(); 
}

function Upload-FileToMasterPageGallery{
[CmdletBinding()]
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true)]
    [string]$WebUrl,
    [Parameter(Mandatory=$true)]
    [string]$SourceFilePath,
    [Parameter(Mandatory=$true)]
    [string]$DestFilePath,
    [Parameter(Mandatory=$true)]
    [string]$ContentType,
    [Parameter(Mandatory=$false)]
    [string]$AssociatedPublishingContentType
    )

    $Web = Get-SPWeb $WebUrl;
    $MasterPageFolder = $web.GetFolder("Master Page Gallery");
    $DestFilePath = $DestFilePath.TrimStart("/");

    #Get the Master page from local disk
    $MasterPageSourceFile = (Get-ChildItem $SourceFilePath).OpenRead()
 
    #upload master page using powershell
    $MasterPageSPFile = $MasterPageFolder.Files.Add($DestFilePath,$MasterPageSourceFile,$true);
    $MasterPageSPFile.CheckOut();    

    $FileContentType = $web.AvailableContentTypes[$ContentType];

    Log "`tUpdate content type to $($FileContentType.Name) on file $($MasterPageSPFile.Name) - CheckoutStats:$($MasterPageSPFile.CheckOutStatus)";
    $MasterPageSPFile.Item[[Microsoft.SharePoint.SPBuiltInFieldId]::ContentTypeId] = $FileContentType.Id;
    $MasterPageSPFile.Item[[Microsoft.SharePoint.SPBuiltInFieldId]::ContentType] = $FileContentType.Name;
    $MasterPageSPFile.Item["ows_UIVersion"] = 15;

    if(![string]::IsNullOrEmpty($AssociatedPublishingContentType))
    {
        Log "`tSet associated publishing content type: $($AssociatedPublishingContentType)";
        $AssociatedContentType = $web.AvailableContentTypes[$AssociatedPublishingContentType];
        $MasterPageSPFile.Item["PublishingAssociatedContentType"] = [string]::Format(";#{0};#{1};#", $AssociatedContentType.Name, $AssociatedContentType.Id.ToString());
    }

    $MasterPageSPFile.Item.Update();
    $MasterPageSPFile.CheckIn("");                       
    $MasterPageSPFile.Publish("");   
      
    $MasterPageSourceFile.Dispose();
    $web.Dispose();                 
}

function Set-PublishingCustomMasterUrl
{
    [CmdletBinding()]    
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$WebUrl,
        [Parameter(Mandatory=$true)]
        [string]$MasterUrl
    )
        
    $Web = Get-SPWeb $WebUrl;
    Log "`tSet MasterPage Url to $($masterUrl) on Web $($web.Url)";
    $web.CustomMasterUrl = $masterUrl;
    $web.Update()         
    $web.Dispose();   
    Log -Level Success "`tMaster page successfully set";
}

function Add-PublishingPage{
    [CmdletBinding()]    
        Param
        (
            [Parameter(Mandatory=$true)]
            [string]$WebUrl,
            [Parameter(Mandatory=$true)]
            [string]$Title,
            [Parameter(Mandatory=$true)]
            [string]$Path,
            [Parameter(Mandatory=$true)]
            [string]$PageLayout,
            [switch]$SetAsWelcomePage
        )
    
    $Web = Get-SPWeb $WebUrl;    
    $pweb = [Microsoft.SharePoint.Publishing.PublishingWeb]::GetPublishingWeb($web)
    $layouts = $pweb.GetAvailablePageLayouts();
    $Path = $Path.TrimStart("/");

    $destPagePath = "pages/$($Path)";    
    $destLayout = $layouts | ? { $_.Title -eq $PageLayout }
    $pages = $pweb.GetPublishingPages($pweb);

    Log "`tAdding page $($destPagePath) to web $($web.Url)";

    if ($Web.GetFile($destPagePath).Exists) { 
        $pageItem = $Web.GetFile($destPagePath).Item;
        $Page = [Microsoft.SharePoint.Publishing.PublishingPage]::GetPublishingPage($pageItem); 
        if($Page.ListItem.File.CheckoutStatus -eq "None"){
            $Page.CheckOut();
        }
    }
    else{
        $Page = $pages.Add($Path, $destLayout);
    }

    $item = $page.ListItem;
    $item["Title"] = $PageTitle;    
    $item.Update() 
    $item.File.CheckIn("")
    $item.File.Publish("")

    if($SetAsWelcomePage)
    {
        Set-WebWelcomePage -WebUrl $web.Url -Path $destPagePath
    }

    $web.Dispose();   
} 

function Set-WebWelcomePage
{
    [CmdletBinding()]    
        Param
        (
            [Parameter(Mandatory=$true)]
            [string]$WebUrl,
            [Parameter(Mandatory=$true)]
            [string]$Path)

    $Web = Get-SPWeb $WebUrl;    
    Log "`tSetting welcome page to $($Path) on web $($web.Url)";
    $root = $web.RootFolder   
    $root.WelcomePage = $Path;
    $root.Update()   
    $web.Update()      
    $web.Dispose();   
}

function SetListPermissionForGroup
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web,
    [string]$ListName,
    [string]$GroupName,
    [string]$Role
    )

    $list = $Web.Lists.TryGetList($ListName);
    if ($list -eq $null) 
    {
        Write-Host "Cannot find list $ListName";
        return;
    }

    $group = $Web.SiteGroups[$GroupName];

    $listRole = $Web.RoleDefinitions[$Role];

    $list.BreakRoleInheritance($true, $true);

    $listRoleAssignment = New-Object Microsoft.SharePoint.SPRoleAssignment($group);
    $listRoleAssignment.RoleDefinitionBindings.Add($listRole);
    $list.RoleAssignments.Add($listRoleAssignment);

    $list.Update();
}
