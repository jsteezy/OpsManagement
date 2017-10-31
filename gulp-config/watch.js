var gulp = require("gulp");
// var envConfig = require("../src/app/config/envConfig.json");
// var gutil = require("gulp-util");
// var gulpSettings = require("./gulpSettings.json");

gulp.task("watch", function() {
    gulp.watch([
        "./src/assets/img/**/*",
        "./src/assets/fonts/**/*",
        "./src/assets/i18n/**/*"
    ], ["copy"]);

    gulp.watch([
        "./src/index.html"
    ], ["baseTagInject"]);

    gulp.watch(["./src/assets/**/*.less"], ["less-core"]);
    gulp.watch(["./src/app/**/*.less"], ["less-core"]);

    gulp.watch([
        "./src/app/**/*.html",
        "./src/app/**/*.js",
        "./src/app/**/*.json",
        "./src/app/**/*.txt",
        "./src/assets/polyfills/**/*.js"
    ], ["js-core"]);

    // gulp.task("copy", function() {
    //     gulp.src([gulpSettings.distFolder + "/js"])
    //         .pipe(gulp.dest(envConfig.site_url + "/ProjectLibrary/OMT/js"));
    //     gutil.log(envConfig.site_url + "Trying to move js to sharepoint");
    // });
});