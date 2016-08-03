var gulp = require('gulp');
var coffeelint = require('gulp-coffeelint');
var coffee = require('gulp-coffee');
var gutil = require('gutil');

//check coffee project
gulp.task('lint', function () {
    gulp.src('/*.coffee')
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())
});
//compile project files to .js
gulp.task('coffee', function() {
    gulp.src('./*.coffee')
        .pipe(coffee({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest('./public/'));
});
//compile coffee tests spec
gulp.task('coffeeTests', function() {
    gulp.src('./spec/**/*.coffee')
        .pipe(coffee({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest('./spec/jsSpec/'));
});
//tests watcher
gulp.task('coffeeTests:watch', function () {
    gulp.watch('./spec/*.coffee', ['coffeeTests']); 
});
gulp.task('default', function() {
    gulp.start("coffee", "coffeeTests");
});