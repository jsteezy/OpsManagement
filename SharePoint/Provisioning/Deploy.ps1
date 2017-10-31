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

Log "Configuring App Master Page and Page Layout"

Upload-FileToMasterPageGallery -WebUrl $web.Url `
                                -SourceFilePath "$($PSScriptRoot)\..\Files\$($global:masterPageFileName)" `
                                -DestFilePath "/_catalogs/masterpage/$($global:masterPageFileName)" `
                                -ContentType $global:masterPageContentType

Upload-FileToMasterPageGallery -WebUrl $web.Url `
                                -SourceFilePath "$($PSScriptRoot)\..\Files\css\$($global:masterPageCssFileName)" `
                                -DestFilePath "/_catalogs/masterpage/OMT/css/$($global:masterPageCssFileName)" `
                                -ContentType $global:designContentType

Upload-FileToMasterPageGallery -WebUrl $web.Url `
                                -SourceFilePath "$($PSScriptRoot)\..\Files\$($global:spaPageLayoutFileName)" `
                                -DestFilePath "/_catalogs/masterpage/OMT/$($global:spaPageLayoutFileName)" `
                                -ContentType $global:pageLayoutContentType

Log "Base SPA Brandinggration completed"

$web.Update();