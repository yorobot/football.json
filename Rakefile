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
  debug_value = ENV['DEBUG']
  if debug_value &&  ['true', 't', 'yes', 'y'].include?( debug_value.downcase )
    true
  else
    false
  end
end


def load_tasks
  Dir.glob('./tasks/**/*.rake').each do |r|
    puts "  importing task >#{r}<..."
    import r      ## why use import and not load? load works with .rake extension?
    # see blog.smartlogicsolutions.com/2009/05/26/including-external-rake-files-in-your-projects-rakefile-keep-your-rake-tasks-organized/
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
  'database' =>  './build/sport.db'
}



## load database config from external file (easier to configure/change)
## DB_HASH   = YAML.load( ERB.new( File.read( './database.yml' )).result )
## DB_CONFIG = DB_HASH[ 'default' ]    ## for now just always use default section/entry



task :default => :build

directory BUILD_DIR


task :clean do
  db_adapter  = DB_CONFIG[ 'adapter' ]
  db_database = DB_CONFIG[ 'database' ]

  ### for sqlite3 delete/remove single-file database
  if db_adapter == 'sqlite3' && db_database != ':memory:'
     db_database =  DB_CONFIG[ 'database' ]
     rm db_database if File.exists?( db_database )
  else
    puts "  clean: do nothing; no clean steps configured for db adapter >#{db_adapter}<"
  end
end



task :env => BUILD_DIR do
  pp DB_CONFIG
  ActiveRecord::Base.establish_connection( DB_CONFIG )

  db_adapter  = DB_CONFIG[ 'adapter' ]
  db_database = DB_CONFIG[ 'database' ]

  if db_adapter == 'sqlite3' && db_database != ':memory:'
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
  # logger.level = :info

  ## log all warns, errors, fatals to db
  LogDb.setup
  logger.warn "Rakefile - #{Time.now}"  # say hello; log to db (warn level min)

  ## try first
  ### use DEBUG=t or DEBUG=f
  ### or alternative LOG|LOGLEVEL=debug|info|warn|error
  debug_key = ENV['DEBUG']
  if debug_key.nil?
    ## try log_key as "fallback"
    ##  - env variable that lets you configure log level
    log_key = ENV['LOG'] || ENV['LOGLEVEL'] || 'debug'
    puts "  using LOGLEVEL >#{log_key}<"
    logger.level = log_key.to_sym
  else
    if ['true', 't', 'yes', 'y'].include?( debug_key.downcase )
      logger.level = :debug
    else
      logger.level = :info
    end
  end
end


task :create => :env do
  SportDb.create_all
end



############################################
# add more tasks (keep build script modular)

load_tasks()   ## e.g. see scripts/rake.rb -- (auto-)imports ./tasks/**/*.rake


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


DATA_KEY = ENV['DATA'] || ENV['DATASET'] || 'all'     ## note: was 'worldcup' default DATA_KEY
puts "  using DATA_KEY >#{DATA_KEY}<"

task :read => [:config, DATA_KEY.to_sym] do
  # nothing here
end


task :it => :config do
  SportDb.read( IT_DIR )   ## add season: '2019/20' - why? why not?
end


###
## from "new" update build script

## note: :ru not working for now (fix date e.g. [])
task :all => [:at,:de,:en,:es,:it] do
end


desc 'build football.db from scratch (default)'
task :build => [:clean, :create, :read] do
  puts 'Done.'
end


task :json => :config  do       ## for in-memory depends on all for now - ok??
  out_root = debug? ? './build' : FOOTBALL_JSON_DIR

  # gen_json( 'at',   out_root: out_root )
  # gen_json( 'at.2', out_root: out_root )
  # gen_json( 'de',   out_root: out_root )
  # gen_json( 'de.2', out_root: out_root )
  # gen_json( 'en',   out_root: out_root )
  # gen_json( 'es',   out_root: out_root )
  gen_json( 'it.1',   out_root: out_root )
end



