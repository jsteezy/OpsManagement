Build Intructions

0. Pull TARv2 Branch and create a local repository.

1. Download and install node.js from https://nodejs.org/en/

2. Pull the latest version of the TAR application from bittbucket (TARv2 branch)

3. Open node.js command prompt and switch to the drive and folder where your TAR application is mapped

4. In the root folder run the following commands
	npm install
	npm install -g gulp

5. Set the path for gulp destination folder.:
    The configuration property is in "gulp-config/gulpSettings.json".
    Change the "distFolder" property (most probably this will be "./dist").

6. Set the configurations for environment:
   Check the env config gile -> src/app/config/envConfig.json
   Set the "site_url" property which will be the base url for you api calls. For example "http://sci-tar.evozon.com".
   Set the "baseUrl" property which will be the path on the server, starting from site base url. So, for example if the site base url is
   "http://sci-tar.evozon.com" and the application is placed into "ProjectLibrary/TAR", then the "baseUrl" should be "/ProjectLibrary/TAR/"

7. Run "gulp" command


For the moment, if you still want to test the app on localhost:

*5. Set the path for gulp destination folder to "./dist"

*6. Ignore in envConfig "site_url" and set "baseUrl" to "/"(this is because the web server will run on current dist folder)

*7. Run gulp and then start your browser at localhost:9000/index.html

--------------------------------------------------------------------------------------------------------------------------------------------
DEPLOYMENT

1. Make sure that the 2 environment variables in "src/app/config/envConfig.json" are set appropriately.
    - site_url: should contain the full path of the site collection (including the managed path)
    - baseUrl: sould contain the managed path and the path to the solution library

2. Open a command prompt and navigate to the folder where the solution is stored and execute a "gulp" command.

3. Navigate to <SITE_URL>/_catalogs/masterpage/ , create a folder named "TAR" and inside the this folder create a folder named "css". 

4. Open the folder "SharePoint\Provisioning\" and open the file "Config.ps1".

5. Modify the following variables accordingly:
    $global:spWebAppUrl - the web application URL 
    $global:spSiteUrl - the site collection URL where the solution will be hosted
    $global:solutionPath - the path on the disk where the solution is stored (ex. the "dist" folder)
    $global:documentLibraryName - the document library name where the solution will be stored
    $global:documentLibraryFolder - the folder name in the $global:documentLibraryName where the solution will be deployed
    
6. Run "Deploy.ps1".

7. Create a new page that has as layout the "ApplicationSPALayout.aspx" page.

8. In the newly created page add in the Main Zone (web part zone) a new Content Editor Web Part.

9. Edit the Content Editor Web Part and insert the reference to the index.html file from the uploaded solution. Make sure that in the Appearance tab, the property "Chrome State"
is set to Normal and in the "Chrome Type" dropdown is selected None. 

*10. If steps 6 or 7 do not work, use the "ApplicationSPALayout.aspx" layout page as the actual page and perform step 7 on it.

11. Upload workflows by running the script "UploadWorkflows.ps1".

--------------------------------------------------------------------------------------------------------------------------------------------
USER PROFILES

Create new list:
	- Execute "Generate-UserProfiles.ps1 -StartIndex {INDEX} -Count {COUNT}" where:
		- {INDEX} is the greatest index number from the previously created User Profile lists
		- {COUNT} is the number of User Profile lists you want to create at a time
		
	- If you want to modify the threshold of the User Profile list, open "Generate-UserProfiles.ps1" and modify the variable "$global:ListSize"; the default value is 4000.
	
	
Modify the config file in the Angular application:
	- The User Profile config file name is "profileListLimits.json".
	- When you insert another limit please make sure they are in increasing order, and also specify the list name.
	
--------------------------------------------------------------------------------------------------------------------------------------------
TAR EXPORT

The export script that will be put on a job is "Generate-ExcelExport.ps1".

Parameters: 
	- "WebUrl"
	- "DocLibraryName" - the name of the Document Library where the Excel will be stored (The Document Library must exist prior to executing the script.)
	
--------------------------------------------------------------------------------------------------------------------------------------------
MIGRATION

Scripts: 
	- ExportData.ps1
	- ExportUsers.ps1
	- ImportData.ps1
	- ImportUsers.ps1
	
Also, the Migration folder must be in the same place with the mentioned scripts.

--------------------------------------------------------------------------------------------------------------------------------------------
WORKFLOW TROUBLESHOOTING

* Terminating a TAR approval workflow: 
	- make sure that all the tasks associated to the workflow have been completed(approved or rejected) or deleted
	- terminate the workflow (can be restarted manually at any time)

* Upload new TAR approval workflow:
	- for the old version remove the Add event association; needed to make sure that all current submitted TARs will complete the approval and for no new TARs this workflow will be triggered
	- upload the new workflow version using the script "UploadWorkflows.ps1"
	- when all TARs that had been using the old approval are completed (rejected or approved), delete the old version of the workflow