#############################################
# build script (ruby make) for football.db
#
#  use:
#   $ rake   or
#   $ rake build     - to build football.db from scratch
#
#   $ rake -T        - show all tasks


$RUBYLIBS_DEBUG = true


require 'json'    ## check if needed - really?

# 3rd party libs/gems
require 'sportdb/readers'
require 'logutils/activerecord' ## add db logging




def debug?
  debug = ENV['DEBUG']
  if debug &&  ['true', 't', 'yes', 'y'].include?( debug.downcase )
    true
  else
    false
  end
end



BUILD_DIR = "./build"


OPENFOOTBALL_DIR = "../../openfootball"

################
# clubs
IT_DIR  = "#{OPENFOOTBALL_DIR}/italy"

##  used by json task
FOOTBALL_JSON_DIR = "#{OPENFOOTBALL_DIR}/football.json"



require_relative 'scripts/json'




# note:
#   uses (configured) for SQLite in-memory database
#      e.g. there's no BUILD_DIR (and database on the file system)
#

# DB_CONFIG = {
#   'adapter'  => 'sqlite3',
#   'database' => ':memory:'
# }

###
# for testing/debuggin change to file
#   note: use string keys (not symbols!!! e.g. 'adapter' NOT adapter: etc.)

DB_CONFIG = {
  'adapter'  =>  'sqlite3',
  'database' =>  "#{BUILD_DIR}/sport.db"
}



## load database config from external file (easier to configure/change)
## DB_HASH   = YAML.load( ERB.new( File.read( './database.yml' )).result )
## DB_CONFIG = DB_HASH[ 'default' ]    ## for now just always use default section/entry


task :default => :build


task :clean do
  adapter  = DB_CONFIG[ 'adapter' ]
  database = DB_CONFIG[ 'database' ]

  ### for sqlite3 delete/remove single-file database
  if adapter == 'sqlite3' && database != ':memory:'
     rm database  if File.exists?( database )
  else
    puts "  clean: do nothing; no clean steps configured for db adapter >#{adapter}<"
  end
end

directory BUILD_DIR

task :env => BUILD_DIR do
  pp DB_CONFIG
  ActiveRecord::Base.establish_connection( DB_CONFIG )

  adapter  = DB_CONFIG[ 'adapter' ]
  database = DB_CONFIG[ 'database' ]

  if adapter == 'sqlite3' && database != ':memory:'
    puts "*** sqlite3 database on filesystem; try speedup..."
    ## try to speed up sqlite
    ## see http://www.sqlite.org/pragma.html
    c = ActiveRecord::Base.connection
    c.execute( 'PRAGMA synchronous=OFF;' )
    c.execute( 'PRAGMA journal_mode=OFF;' )
    c.execute( 'PRAGMA temp_store=MEMORY;' )
  end
end



task :config  => :env  do
  logger = LogUtils::Logger.root

  ## log all warns, errors, fatals to db
  LogDb.setup
  logger.warn "Rakefile - #{Time.now}"  # say hello; log to db (warn level min)

  ## use DEBUG=t or DEBUG=f
  logger.level = if debug? 
                   :debug 
                 else
                   :info
                 end
end


task :create => :env do
  SportDb.create_all
end


#########################################################
# note: change deps to what you want to import for now

##
# default to worldcup (if no key given)
#
# e.g. use like
#  $ rake update DATA=admin  or
#  $ rake build  DATA=all
#  $ rake build  DATA=en
#  etc.

task :it => :config do
  SportDb.read( IT_DIR )   ## add season: '2019/20' - why? why not?
end

## note: :ru not working for now (fix date e.g. [])
task :all => [:at,:de,:en,:es,:it] do
end


DATA_KEY = ENV['DATA'] || ENV['DATASET'] || 'all'     ## note: was 'worldcup' default DATA_KEY
puts "  using DATA_KEY >#{DATA_KEY}<"

desc 'build football.db from scratch (default)'
task :build => [:clean, :create, DATA_KEY.to_sym] do
  puts 'Done.'
end


task :json => :config  do       ## for in-memory depends on all for now - ok??
  out_root = if debug? 
               BUILD_DIR
             else
               FOOTBALL_JSON_DIR
             end

  # gen_json( 'at',   out_root: out_root )
  # gen_json( 'at.2', out_root: out_root )
  # gen_json( 'de',   out_root: out_root )
  # gen_json( 'de.2', out_root: out_root )
  # gen_json( 'en',   out_root: out_root )
  # gen_json( 'es',   out_root: out_root )
  gen_json( 'it.1',   out_root: out_root )
end

