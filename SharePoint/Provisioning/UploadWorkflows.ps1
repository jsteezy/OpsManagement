. "$($PSScriptRoot)\Config.ps1"

# Load the WorkflowServicesManager client library
Add-Type -Path “C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll”
Add-Type -Path “C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll”
Add-Type -Path “C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.WorkflowServices.dll”

Add-PSSnapin Microsoft.SharePoint.Powershell

function UploadWorkflows()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string]$SiteUrl
    )

    $context = New-Object Microsoft.SharePoint.Client.ClientContext($SiteUrl)

    if ($context -eq $null)
    {
        Log -Level Error -Msg "Error when creating context";
        return;
    }

    $credentials = Get-Credential

    $context.Credentials = $credentials.GetNetworkCredential();
    $context.AuthenticationMode = [Microsoft.SharePoint.Client.ClientAuthenticationMode]::Default;

    HandleMixedModeWebApplication $context

    if ($context.ServerObjectIsNull.Value)
    {
        Log -Level Error -Msg "Could not create client context";
        return;
    }

    UploadListWorkflow -Context $context -SiteUrl $SiteUrl -ListName "TAR Requests" -WorkflowProperties $global:TARApprovalWorkflowProperties 
    UploadListWorkflow -Context $context -SiteUrl $SiteUrl -ListName "EIF Requests" -WorkflowProperties $global:EIFSubmittedWorkflowProperties
    UploadSiteWorkflow -Context $context -SiteUrl $SiteUrl -WorkflowProperties $global:TARArchivingWorkflowProperties
    UploadSiteWorkflow -Context $context -SiteUrl $SiteUrl -WorkflowProperties $global:EIFArchivingWorkflowProperties
}

function UploadSiteWorkflow
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.Client.ClientContext]$Context,
    [string]$SiteUrl,
    [hashtable]$WorkflowProperties
    )

    $web = $Context.Web
    Write-Host $web.ID
    $Context.Load($web)
    $Context.ExecuteQuery()

    if ($web -eq $null) 
    {
        Log -Level Error -Msg "Error grabbing the web from context";
        return;
    }

    Write-Host $web.Title

    # Create a WorkflowServicesManager instance
    $wfManager = New-Object Microsoft.SharePoint.Client.WorkflowServices.WorkflowServicesManager($Context, $Context.Web)

    # Get a reference to the Workflow Deployment Service
    $wfDeploymentService = $wfManager.GetWorkflowDeploymentService()

    $xaml = [System.Xml.Linq.XElement]::Load($WorkflowProperties.Get_Item("XAMLPath"))

    $xaml = ProcessWorkflowXaml -SiteUrl $SiteUrl -xaml $xaml

    if ($xaml -eq $null)
    {
        Log -Level Error -Msg "Cannot find workflow $($WorkflowProperties.Get_Item("Name"))."
        return;
    }

    $wfDefinition = New-Object Microsoft.SharePoint.Client.WorkflowServices.WorkflowDefinition($Context)
    $wfDefinition.DisplayName = $WorkflowProperties.Get_Item("Name");
    $wfDefinition.Description = $WorkflowProperties.Get_Item("Description");
    $wfDefinition.Xaml = $xaml.ToString()

    #save workflow definition
    $definitionId = $wfDeploymentService.SaveDefinition($wfDefinition)
    $Context.Load($wfDefinition)
    $Context.ExecuteQuery()

    #publish workflow definition
    $wfDeploymentService.PublishDefinition($definitionId.Value);

    $historyListName = $WorkflowProperties.Get_Item("HistoryList")
    $historyList = GetList -ListName $historyListName -Context $Context -Web $web
    if ($historyList -eq $null) 
    {
        Log -Level Error -Msg "Cannot upload workflow... List $historyListName not found."
        return;
    }

    $tasksListName = $WorkflowProperties.Get_Item("TasksList");
    $tasksList = GetList -ListName $tasksListName -Context $Context -Web $web
    if ($tasksListName -eq $null) 
    {
        Log -Level Error -Msg "Cannot upload workflow... List $tasksListName not found."
        return;
    }
    
    #Associate the Workflow Definition to a target site
    $wfSubscriptionService = $wfManager.GetWorkflowSubscriptionService()
    $wfSubscription = New-Object Microsoft.SharePoint.Client.WorkflowServices.WorkflowSubscription($Context)

    #Configure the Workflow Subscription
    $wfSubscription.DefinitionId = $definitionId.Value
    $wfSubscription.Name = $wfDefinition.DisplayName
    $wfSubscription.Enabled = $true
    
    # Available values are: ItemAdded, ItemUpdated, WorkflowStart
    $eventTypesString = $WorkflowProperties.Get_Item("Events")
    $eventTypes = New-Object System.Collections.Generic.List[String]
    $eventTypes.AddRange($eventTypesString.Split(','))

    $wfSubscription.EventTypes = $eventTypes;
    $wfSubscription.EventSourceId = $web.ID.ToString()
    $wfSubscription.SetProperty(“TaskListId”, $tasksList.Id.ToString())
    $wfSubscription.SetProperty(“HistoryListId”, $historyList.Id.ToString())

    # Publish the Workflow Subscription
    $wfSubscriptionService.PublishSubscription($wfSubscription)
    $Context.ExecuteQuery()
}

function UploadListWorkflow()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.Client.ClientContext]$Context,
    [string]$SiteUrl,
    [string]$ListName,
    [hashtable]$WorkflowProperties
    )

    $web = $Context.Web
    $Context.Load($web)
    $Context.ExecuteQuery()

    if ($web -eq $null) 
    {
        Log -Level Error -Msg "Error grabbing the web from context";
        return;
    }

    Write-Host $web.Title

    # Create a WorkflowServicesManager instance
    $wfManager = New-Object Microsoft.SharePoint.Client.WorkflowServices.WorkflowServicesManager($Context, $Context.Web)

    # Get a reference to the Workflow Deployment Service
    $wfDeploymentService = $wfManager.GetWorkflowDeploymentService()

    $xaml = [System.Xml.Linq.XElement]::Load($WorkflowProperties.Get_Item("XAMLPath"))

    $xaml = ProcessWorkflowXaml -SiteUrl $SiteUrl -xaml $xaml

    if ($xaml -eq $null)
    {
        Log -Level Error -Msg "Cannot find workflow $($WorkflowProperties.Get_Item("Name"))."
        return;
    }

    $wfDefinition = New-Object Microsoft.SharePoint.Client.WorkflowServices.WorkflowDefinition($Context)
    $wfDefinition.DisplayName = $WorkflowProperties.Get_Item("Name");
    $wfDefinition.Description = $WorkflowProperties.Get_Item("Description");
    $wfDefinition.Xaml = $xaml.ToString()

    #save workflow definition
    $definitionId = $wfDeploymentService.SaveDefinition($wfDefinition)
    $Context.Load($wfDefinition)
    $Context.ExecuteQuery()

    #publish workflow definition
    $wfDeploymentService.PublishDefinition($definitionId.Value)

    $targetList = GetList -ListName $ListName -Context $Context -Web $web
    if ($targetList -eq $null)
    {
        Log -Level Error -Msg "Cannot upload workflow... List $targetList not found."
        return;
    }

    $historyListName = $WorkflowProperties.Get_Item("HistoryList")
    $historyList = GetList -ListName $historyListName -Context $Context -Web $web
    if ($historyList -eq $null) 
    {
        Log -Level Error -Msg "Cannot upload workflow... List $historyListName not found."
        return;
    }

    $tasksListName = $WorkflowProperties.Get_Item("TasksList");
    $tasksList = GetList -ListName $tasksListName -Context $Context -Web $web
    if ($tasksListName -eq $null) 
    {
        Log -Level Error -Msg "Cannot upload workflow... List $tasksListName not found."
        return;
    }

    #Associate the Workflow Definition to a target list/library
    $wfSubscriptionService = $wfManager.GetWorkflowSubscriptionService()
    $wfSubscription = New-Object Microsoft.SharePoint.Client.WorkflowServices.WorkflowSubscription($Context)

    #Configure the Workflow Subscription
    $wfSubscription.DefinitionId = $definitionId.Value
    $wfSubscription.Name = $wfDefinition.DisplayName
    $wfSubscription.Enabled = $true
    
    # Available values are: ItemAdded, ItemUpdated, WorkflowStart
    $eventTypesString = $WorkflowProperties.Get_Item("Events")
    $eventTypes = New-Object System.Collections.Generic.List[String]
    $eventTypes.AddRange($eventTypesString.Split(','))

    $wfSubscription.EventTypes = $eventTypes;
    $wfSubscription.EventSourceId = $targetList.Id.ToString()
    $wfSubscription.SetProperty(“TaskListId”, $tasksList.Id.ToString())
    $wfSubscription.SetProperty(“HistoryListId”, $historyList.Id.ToString())

    # Publish the Workflow Subscription
    $wfSubscriptionService.PublishSubscriptionForList($wfSubscription, $targetList.Id)
    $Context.ExecuteQuery()
}

function ProcessWorkflowXaml()
{
     [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string]$SiteUrl,
    [string]$xaml
    )

    $web = Get-SPWeb $SiteUrl

    $newXaml = $xaml

    $xaml | select-string -Pattern '{\$ListId:Lists\/(.*);}' -AllMatches | Foreach {$_.Matches} | Foreach {

        $listName = $_.Groups[1].Value

        $list = $web.Lists | Where {$_.RootFolder.Name -eq $listName}

        if ($list -ne $null)
        {
            $newXaml = $newXaml.Replace($_.Groups[0], "{" + $list.ID + "}")
        }

    }

    $newXaml = $newXaml.Replace('WaitForTaskCompletion="True">', 'WaitForTaskCompletion="True" WaiveAssignmentEmail="True" WaiveCancelationEmail="True">');

    return $newXaml
}

function HandleMixedModeWebApplication()
{
  param([Parameter(Mandatory=$true)][object]$clientContext)  
  Add-Type -TypeDefinition @"
  using System;
  using Microsoft.SharePoint.Client;
  
  namespace TAR.SPOHelpers
  {
      public static class ClientContextHelper
      {
          public static void AddRequestHandler(ClientContext context)
          {
              context.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>(RequestHandler);
          }
  
          private static void RequestHandler(object sender, WebRequestEventArgs e)
          {
              //Add the header that tells SharePoint to use Windows authentication.
              e.WebRequestExecutor.RequestHeaders.Remove("X-FORMS_BASED_AUTH_ACCEPTED");
              e.WebRequestExecutor.RequestHeaders.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f");
          }
      }
  }
"@ -ReferencedAssemblies "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll", "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll";
  [TAR.SPOHelpers.ClientContextHelper]::AddRequestHandler($clientContext);
}

function GetList()
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string]$ListName,
    [Microsoft.SharePoint.Client.ClientContext]$Context,
    [Microsoft.SharePoint.Client.Web]$Web
    )

    $list = $Web.Lists.GetByTitle($ListName)
    $Context.Load($list)
    $Context.ExecuteQuery()

    return $list
}

#Main
UploadWorkflows -SiteUrl $global:spSiteUrl