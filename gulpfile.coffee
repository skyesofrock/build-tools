# All uncompiled files should be kept inside `site/dev` folder
# Place all files in relevant subfolders and reference as appropriate
gulp = require 'gulp'
sass = require 'gulp-sass'
nano = require 'gulp-cssnano'
prefix = require 'gulp-autoprefixer'
rename = require 'gulp-rename'
coffee = require 'gulp-coffee'
plumber = require 'gulp-plumber'

# By default only outputting minified css
# Uncomment `.pipe gulp.dest 'site/css'` to output standard css
gulp.task 'sass', ->
  gulp.src 'site/dev/scss/*.scss'
    # .pipe plumber()
    .pipe sass()
    .pipe prefix 'last 2 versions'
    # .pipe gulp.dest 'site/css'
    .pipe nano
      zindex: false
    .pipe rename
      extname: '.min.css'
    # .pipe plumber.stop()
    .pipe gulp.dest 'site/css'

gulp.task 'coffee', ->
  gulp.src 'site/dev/coffee/*.coffee'
    # .pipe plumber()
    .pipe coffee
      bare: true
    # .pipe plumber.stop()
    .pipe gulp.dest 'site/js'

# For use from CLI
# Uncomment `plumber` pipes to prevent `gulp watch` crashing on errors
gulp.task 'watch', ['sass', 'coffee'], ->
  gulp.watch 'site/dev/scss/*.scss', ['sass']
  gulp.watch 'site/dev/coffee/*.coffee', ['coffee']

# Specfic build task for use with systems supporting build on save or similar
# i.e. build for Atom
# Set this task as the build target
# Set `plumber` lines as comments, or build system won't pick up errors
gulp.task 'build', ['sass', 'coffee']
