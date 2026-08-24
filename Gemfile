##
##  tip for github actions
##
##   $ bundle install    -- generates Gemfile.lock BUT incl. only local platform
##                                          (e.g. x64-mingw-ucrt)
##  add github actions linux platform and "generic" ruby
##    $ bundle lock --add-platform ruby
##    $ bundle lock --add-platform x86_64-linux

##
##  if Gemfile location different from ./ maybe also set
##   If there is a Gemfile.lock (or $BUNDLE_LOCKFILE
##     in addition to $BUNDLE_GEMFILE !!!

##
##  note - ruby setup task for bundle install gems into $PWD/vendor/bundle
##         e.g.    football.json/vendor/bundle !!!
##      and not into system/default
##    bundle config --local path $PWD/vendor/bundle

source "https://rubygems.org"

## note - yorobot includes / pulls-in  the mono(s) w/ monofile machinery (gems)
gem "yorobot"


gem "cocos"
gem "season-formats"

##  note - always checkout latest via git (see sportdb/sport.db.v2)
##  gem "sportdb-quick"

### add   gem "fbtxt/lexer" etc. with   :path option - why? why not?
###   to work MUST use monotree layout
##    note -  github by default uses nested and "flat" checkouts
##    will NOT preserve  owner/repo structure!!
##     maybe change the   checkout to ALWAYS use  owner/repo structure - why? why not?