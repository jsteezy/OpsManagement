$global:spWebAppUrl = "https://onenet-staging.savethechildren.net";
$global:spSiteUrl = "$($global:spWebAppUrl)/sites/OMT";

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

$global:featuresToEnable = @("TeamCollab", "WorkflowAppOnlyPolicyManager", "PublishingSite", "PublishingWeb");

$location = $PSScriptRoot
$parentLocation = (Get-Item $location).parent.FullName