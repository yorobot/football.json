#############################################
# build script (ruby make) for football.db
#
#  use:
#   $ rake   or
#   $ rake build     - to build football.db from scratch
#
#   $ rake -T        - show all tasks


$RUBYLIBS_DEBUG = true


# 3rd party libs/gems
require 'sportdb/readers'



OPENFOOTBALL_DIR = "../../openfootball"

################
# club country repos
AT_DIR  = "#{OPENFOOTBALL_DIR}/austria"
DE_DIR  = "#{OPENFOOTBALL_DIR}/deutschland"
EN_DIR  = "#{OPENFOOTBALL_DIR}/england"
ES_DIR  = "#{OPENFOOTBALL_DIR}/espana"
IT_DIR  = "#{OPENFOOTBALL_DIR}/italy"

##  used by json export/generate task
FOOTBALL_JSON_DIR = "#{OPENFOOTBALL_DIR}/football.json"






BUILD_DIR = "./build"

DB_CONFIG = {
  adapter:   'sqlite3',
  database:  "#{BUILD_DIR}/sport.db"
}

# note:
#   uses (configured) for SQLite in-memory database
#      e.g. there's no BUILD_DIR (and database on the file system)
#
# DB_CONFIG = {
#   adapter:  'sqlite3',
#   database: ':memory:'
# }

#  load database config from external file (easier to configure/change)
#   note: use symbolize_keys if you load config via YAML.load !!!!
#
# DB_HASH   = YAML.load( ERB.new( File.read( './database.yml' )).result )
# DB_CONFIG = DB_HASH[ 'default' ].symbolize_keys    ## for now just always use default section/entry


def debug?
  value = ENV['DEBUG']
  if value && ['true', 't', 'yes', 'y'].include?( value.downcase )
    true
  else
    false
  end
end


task :default => :build


task :clean do
  ### for sqlite3 delete/remove single-file database
  if DB_CONFIG[ :adapter ]  == 'sqlite3'
    database = DB_CONFIG[ :database ]

    rm database  if database != ':memory:' && File.exist?( database )
  end
end


directory BUILD_DIR

task :env => BUILD_DIR do
  SportDb.connect( DB_CONFIG )
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
# default to all (if no key given)
#
# e.g. use like
#  $ rake build  DATA=all  or
#  $ rake build  DATA=en
#  etc.

task :at => :config do
  SportDb.read( AT_DIR, season: '2019/20' )
end

task :de => :config do
  SportDb.read( DE_DIR, season: '2019/20' )
end

task :en => :config do
  SportDb.read( EN_DIR, season: '2019/20' )
end

task :es => :config do
  SportDb.read( ES_DIR, season: '2019/20' )
end

task :it => :config do
  SportDb.read( IT_DIR, season: '2019/20' )
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




require_relative 'scripts/json'    ## pulls in gen_json helper


task :json => :config  do       ## for in-memory depends on all for now - ok??
  out_root = if debug?
               BUILD_DIR
             else
               FOOTBALL_JSON_DIR
             end

  # gen_json( 'at.1', out_root: out_root )
  # gen_json( 'at.2', out_root: out_root )

  gen_json( 'de.1',   out_root: out_root )
  gen_json( 'de.2',   out_root: out_root )
  gen_json( 'eng.1',  out_root: out_root )
  gen_json( 'es.1',   out_root: out_root )
  gen_json( 'it.1',   out_root: out_root )
end

