var gulp = require('gulp');
var inject = require('gulp-inject-string');
var gutil = require("gulp-util");
var envConfig = require('../src/app/config/envConfig.json');
var gulpSettings = require("./gulpSettings.json");

gulp.task('baseTagInject', function(){
    var baseUrl = '\n<base href="' + envConfig.baseUrl + '">';
    var mainCss = '<link rel="stylesheet" type="text/css" href="' + envConfig.baseUrl + 'css/main.css">';
    var coreJs = '	<script src="' + envConfig.baseUrl + 'js/core.js"></script>';
    var shimsJs = '	<script src="' + envConfig.baseUrl + 'js/shims.js"></script>';
    gutil.log(baseUrl);
    
    gulp.src([
            "./src/index.html"
        ])
        .pipe(inject.after('<head>', baseUrl))
        .pipe(inject.before('</head>', mainCss))
        .pipe(inject.before('</body>', shimsJs))
        .pipe(inject.before('</body>', coreJs))
        .pipe(gulp.dest(gulpSettings.distFolder));
});