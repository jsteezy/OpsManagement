. "$($PSScriptRoot)\Config.ps1"
. "$($PSScriptRoot)\SP-HelperFunctions.ps1"
. "$($PSScriptRoot)\DataModel-Definitions.ps1"
. "$($PSScriptRoot)\Deploy-Functions.ps1"
. "$($PSScriptRoot)\UploadFilesInLibrary.ps1"

Add-PSSnapin Microsoft.SharePoint.Powershell

$web = Get-SPWeb $global:spSiteUrl

EnsureAuthorization -web $web

EnsureStorage -web $web

SetListPermissionsForGroups -Web $web

UploadFilesInLibrary -WebUrl $web.Url -FolderPath $global:solutionPath -DocLibName $global:solutionStorageDocLibraryName -DocLibraryFolder $global:documentLibraryFolder



$web.Update();