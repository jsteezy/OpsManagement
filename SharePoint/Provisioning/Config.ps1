$siteURL = "https://amsdev.savethechildren.net";
$global:spSiteUrl = "$($global:spWebAppUrl)/sites/OMT";


$web = Get-SPWeb $siteURL + $global:spSiteUrl
$ct = $web.ContentTypes[$contentType]

if ($ct) {
$ctusage = [Microsoft.SharePoint.SPContentTypeUsage]::GetUsages($ct)
      foreach ($ctuse in $ctusage) {
        $list = $web.GetList($ctuse.Url)
        $contentTypeCollection = $list.ContentTypes;
        $contentTypeCollection.Delete($contentTypeCollection[$ContentType].Id);
        Write-host "Deleted $contentType content type from $ctuse.Url"
        }
$ct.Delete()
Write-host "Deleted $contentType from site."

} else { Write-host "Nothing to delete." }

$web.Dispose()