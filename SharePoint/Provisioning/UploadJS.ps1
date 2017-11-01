."$($PSScriptRoot)\Config.ps1"

Add-PSSnapin Microsoft.SharePoint.Powershell

$libName = 'ProjectLibrary';
$folderName = 'OMT';
$subFolderName = 'js';

$ScriptDirectory = Split-Path $MyInvocation.MyCommand.Path
$diskFolderPathRel = '../../dist/js';
$diskFolderPath = Join-Path $ScriptDirectory $diskFolderPathRel

$web = Get-SPWeb $global:spSiteUrl
$lib = $web.Lists[$libName];
$lib.Title
$folder = $lib.RootFolder.SubFolders[$folderName];
$folder = $folder.Subfolders[$subFolderName]
$files = $folder.Files;
 
$files | select name

$srcFiles = Get-ChildItem -Path $diskFolderPath 

foreach ($file in $srcFiles)
{
     $stream = $file.OpenRead()

      $done= $folder.Files.Add($file.Name, $stream, $true)

      Write-Host $done.Name  "Uploaded into the Site" -ForegroundColor Green
}