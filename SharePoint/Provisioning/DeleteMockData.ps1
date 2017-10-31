Param(
    [string]$WebUrl = $(throw "Web URL is missing")
)

function DeleteTars
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [Microsoft.SharePoint.SPWeb]$Web
    )

    $listName = "TAR Requests"

    $list = $Web.Lists.TryGetList($listName)
    if ($list -eq $null)
    {
        Write-Host "List not found: $listName"
        return
    }

    $query = New-Object Microsoft.SharePoint.SPQuery
    $query.RowLimit = 1000;
    $query.Query = "<Where><BeginsWith><FieldRef Name='Title' /><Value Type='Text'>Mock</Value></BeginsWith></Where>";

    [System.Text.StringBuilder]$batchXml = New-Object System.Text.StringBuilder
    $batchXml.Append("<?xml version=`"1.0`" encoding=`"UTF-8`"?><Batch>")
    $command = [System.String]::Format("<Method><SetList>{0}</SetList><SetVar Name=`"ID`">{1}</SetVar><SetVar Name=`"Cmd`">Delete</SetVar></Method>", $list.ID, "{0}")

    do 
    {
        $listItems = $list.GetItems($query);
        $query.ListItemCollectionPosition = $listItems.ListItemCollectionPosition

        foreach ($item in $listItems) 
        {
            if ($item -ne $null)
            {
                $batchXml.Append([System.String]::Format($command, $item.ID.ToString()));
            }
        }
    }
    while ($query.ListItemCollectionPosition -ne $null);

    $batchXml.Append("</Batch>");

    $Web.ProcessBatchData($batchXml.ToString());
}

Add-PSSnapin Microsoft.SharePoint.Powershell

$web = Get-SPWeb $WebUrl

DeleteTars -Web $web