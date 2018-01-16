$global:spWebAppUrl = "https://onenet-staging.savethechildren.net";
$global:spSiteUrl = "$($global:spWebAppUrl)/sites/OMT-uat";

$global:solutionPath = "D:\dist";
$global:solutionStorageDocLibraryName = "ProjectLibrary";
$global:documentLibraryFolder = "OMT";
$global:solutionExportDocLibraryName = "OMT Exports";

$global:masterPageFileName = "Application.master";
$global:spaPageLayoutFileName = "ApplicationSPALayout.aspx";
$global:masterPageCssFileName = "omt-master.css";

$global:pageLayoutContentType = "Page Layout";
$global:masterPageContentType = "ASP NET Master Page";
$global:designContentType = "Design";

$location = $PSScriptRoot
$parentLocation = (Get-Item $location).parent.FullName