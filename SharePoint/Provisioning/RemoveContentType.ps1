$siteURL = "https://onenet-staging.savethechildren.net/sites/OMT"
$contentType = "Reports"

$web = Get-SPWeb $siteURL
$ct = $web.ContentTypes[$contentType]

if ($ct) {
$ctusage = [Microsoft.SharePoint.SPContentTypeUsage]::GetUsages($ct)
Write-host $ctusage.Count;
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