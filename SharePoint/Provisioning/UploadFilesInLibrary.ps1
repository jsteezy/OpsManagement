function UploadFilesInLibrary
{
    [CmdletBinding()]            
    Param(            
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]            
    [string]$WebUrl,            
    [Parameter(Mandatory=$true)]            
    [string]$FolderPath,
    [Parameter(Mandatory=$true)]            
    [string]$DocLibName,
    [Parameter(Mandatory=$false)]            
    [string]$DocLibraryFolder = ""         
    ) 

    Write-Host "Uploading solution" -ForegroundColor Yellow

    UploadFiles $WebUrl $FolderPath $DocLibName $DocLibraryFolder

    Write-Host "Solution uploaded" -ForegroundColor Green
}

function UploadFiles
{
    [CmdletBinding()]            
    Param(            
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]            
    [string]$webUrl,                       
    [Parameter(Mandatory=$true)]            
    [string]$FolderPath,
    [Parameter(Mandatory=$true)]            
    [string]$DocLibName, 
    [Parameter(Mandatory=$false)]            
    [string]$DocLibraryFolder = ""     
    )    

	#Stack for keeping the local disk folder paths
    $foldersStack = New-Object System.Collections.Stack
	
	#Stack for keeping the folder paths for the document library
    $spFoldersStack = New-Object System.Collections.Stack

    $foldersStack.Push($FolderPath)

    $web = Get-SPWeb $webUrl
    
    $allowUpdatesStatus = $web.AllowUnsafeUpdates
    $web.AllowUnsafeUpdates = $true

	#Get document library
    $docLibrary = $web.Lists[$DocLibName]
    if ($docLibrary -ne $null)
    {
		if ($DocLibraryFolder -ne "")
        {
            CreateFolder -Web $web -RelativeURL ($web.Url + "/" + $docLibrary.RootFolder) -FolderName $DocLibraryFolder

            #Get the specified folder from the document library
            $folder = $docLibrary.ParentWeb.GetFolder($web.Url + "/" + $docLibrary.RootFolder + "/" + $DocLibraryFolder);

            $spFoldersStack.Push($docLibrary.RootFolder.Name + "/" + $DocLibraryFolder)
        }
        else
        {
            #Get root folder of the document library
            $folder = $docLibrary.RootFolder;

            $spFoldersStack.Push($DocLibName)
        }

        while ($foldersStack.Count -gt 0)
        {
            $currentFolderPath = $foldersStack.Pop();

            $currentSPFolderPath = $spFoldersStack.Pop();

			#Execute only when we are inside sub-folders of the main folder
            if ($currentFolderPath -ne $FolderPath)
            {
                $fileName = $currentSPFolderPath.Substring($currentSPFolderPath.LastIndexOf("\")+1)

                $relativePath = Split-Path -Path $currentSPFolderPath -Parent

                $folder = CreateFolder $web $relativePath $fileName
            }

			#Get file/folder items from the local disk
            $folderItems = Get-ChildItem $currentFolderPath 

            foreach ($item in $folderItems)
            {
                if ($item.Attributes -eq "Directory")
                {
                    $foldersStack.Push($currentFolderPath + "\" + $item.Name)

                    $spFoldersStack.Push($currentSPFolderPath + "/" + $item.Name) 
                }
                else
                {
					#Upload file from local disk to document library
                    UploadFile $folder $item
                }
            }
        }
    }

    $web.AllowUnsafeUpdates = $allowUpdatesStatus

    $web.Dispose()
}

function CreateFolder 
{
    [CmdletBinding()]            
    Param(            
    [Parameter(Mandatory=$true)]            
    [Microsoft.SharePoint.SPWeb]$Web,
    [Parameter(Mandatory=$true)]            
    [string]$RelativeURL,                 
    [Parameter(Mandatory=$true)]            
    [string]$FolderName           
    )

    $folder = $Web.GetFolder($RelativeURL + "/" + $FolderName)
	
    #Check if folder exists
    if (-not $folder.Exists)
    {
        #Write-Host "Add SPFolder $folder to $RelativeURL"

        $folder = $Web.GetFolder($RelativeURL).SubFolders.Add($FolderName)
    }

    return $folder
}

function UploadFile
{
    [CmdletBinding()]            
    Param(            
    [Parameter(Mandatory=$true)]            
    [Microsoft.SharePoint.SPFolder]$Folder,                     
    [Parameter(Mandatory=$true)]            
    [System.IO.FileInfo]$File            
    )   

    #Open file stream
    $fileStream = ([System.IO.FileInfo](Get-Item $File.FullName)).OpenRead()

    #Add file
    [Microsoft.SharePoint.SPFile]$spFile = $Folder.Files.Add($Folder.Url + "/" + $File.Name, [System.IO.Stream]$fileStream, $true)

    #Close file stream
    $fileStream.Close()

	#Update SPListItem of the SPFile
    $spFile.Item["Title"] = $File.Name
    $spFile.Item.Update()
}

