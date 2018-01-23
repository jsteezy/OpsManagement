$global:spWebAppUrl = "https://savethechildren1.sharepoint.com";
$global:spSiteUrl = "$($global:spWebAppUrl)/sites/HART";

$global:solutionPath = "D:\dist";
$global:solutionStorageDocLibraryName = "ProjectLibrary";
$global:documentLibraryFolder = "HART";
$global:solutionExportDocLibraryName = "HART Exports";

$global:masterPageFileName = "Application.master";
$global:spaPageLayoutFileName = "ApplicationSPALayout.aspx";
$global:masterPageCssFileName = "omt-master.css";

$global:pageLayoutContentType = "Page Layout";
$global:masterPageContentType = "ASP NET Master Page";
$global:designContentType = "Design";

$location = $PSScriptRoot
$parentLocation = (Get-Item $location).parent.FullName