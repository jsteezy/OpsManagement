var gulp = require('gulp'),
    spawn = require("child_process").spawn,
    child;



gulp.task('copyJs', function(callback) {
    child = spawn("powershell.exe", ["D://OMT/SharePoint/Provisioning/UploadJS.ps1"]);
    child.stdout.on("data", function(data) {
        console.log("Powershell Data: " + data);
    });
    child.stderr.on("data", function(data) {
        console.log("Powershell Errors: " + data);
    });
    child.on("exit", function() {
        console.log("Powershell Script finished");
    });
    child.stdin.end(); //end input
    callback();
});