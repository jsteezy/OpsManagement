$global:spWebAppUrl = "https://amsdev.savethechildren.net";
$global:spSiteUrl = "$($global:spWebAppUrl)/sites/OMT";

$global:solutionPath = "D:\srcJohn\TAR\dist";
$global:solutionStorageDocLibraryName = "ProjectLibrary";
$global:documentLibraryFolder = "OMT";
$global:solutionExportDocLibraryName = "OMT Exports";

$global:masterPageFileName = "Application.master";
$global:spaPageLayoutFileName = "ApplicationSPALayout.aspx";
$global:masterPageCssFileName = "tar-master.css";

$global:pageLayoutContentType = "Page Layout";
$global:masterPageContentType = "ASP NET Master Page";
$global:designContentType = "Design";

$global:featuresToEnable = @("TeamCollab", "WorkflowAppOnlyPolicyManager", "PublishingSite", "PublishingWeb");

$location = $PSScriptRoot
$parentLocation = (Get-Item $location).parent.FullName

$global:TARApprovalWorkflowProperties = @{"Name" = "TAR Approval Workflow"; "Description" = "TAR Approval Workflow"; "XAMLPath" = "$($parentLocation)\Workflows\TARWorkflow.xaml"; "HistoryList" = "TAR Workflow History"; "TasksList" = "TAR Workflow Tasks"; "Events" = "ItemAdded,WorkflowStart"};
$global:EIFSubmittedWorkflowProperties = @{"Name" = "EIF Submitted Workflow"; "Description" = "EIF Submitted Workflow"; "XAMLPath" = "$($parentLocation)\Workflows\EIFWorkflow.xaml"; "HistoryList" = "TAR Workflow History"; "TasksList" = "TAR Workflow Tasks"; "Events" = "ItemAdded,WorkflowStart"};
$global:TARArchivingWorkflowProperties = @{"Name" = "TAR Archiving Workflow"; "Description" = "TAR Archiving Workflow"; "XAMLPath" = "$($parentLocation)\Workflows\TARArchivingWorkflow.xaml"; "HistoryList" = "TAR Workflow History"; "TasksList" = "TAR Workflow Tasks"; "Events" = "WorkflowStart"};
$global:EIFArchivingWorkflowProperties = @{"Name" = "EIF Archiving Workflow"; "Description" = "EIF Archiving Workflow"; "XAMLPath" = "$($parentLocation)\Workflows\EIFArchivingWorkflow.xaml"; "HistoryList" = "TAR Workflow History"; "TasksList" = "TAR Workflow Tasks"; "Events" = "WorkflowStart"};