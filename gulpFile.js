var gulp = require("gulp");
var runSequence = require("run-sequence");
var requireDir = require("require-dir");
var gulpSettings = require("./gulp-config/gulpSettings.json")

requireDir("./gulp-config");

gulp.task("default", ["runDevelopment"]);

gulp.task("prod", ["runProduction"]);

gulp.task("runDevelopment", function() {
    if (!gulpSettings.isSPEnv) {
        runSequence("clean", "baseTagInject", "copy", "js-core", "js-shims", "less-core", "webserver", "watch");
    } else {
        runSequence("clean", "baseTagInject", "copy", "js-core", "js-shims", "less-core", "copyJs");
    }
});

gulp.task("runProduction", function() {
    runSequence("clean", "baseTagInject", "copy", "js-core", "js-shims", "less-core");
});