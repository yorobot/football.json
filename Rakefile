#############################################
# build script (ruby make) for football.db
#
#  use:
#   $ rake   or
#   $ rake build     - to build football.db from scratch
#
#   $ rake -T        - show all tasks

require_relative 'boot'


################
# club country repos
AT_DIR  = "#{OPENFOOTBALL_DIR}/austria"
DE_DIR  = "#{OPENFOOTBALL_DIR}/deutschland"
EN_DIR  = "#{OPENFOOTBALL_DIR}/england"
ES_DIR  = "#{OPENFOOTBALL_DIR}/espana"
IT_DIR  = "#{OPENFOOTBALL_DIR}/italy"
FR_DIR  = "#{OPENFOOTBALL_DIR}/france"

##
## todo/fix:  remove lang  (rec[2]) - always use league (country) for auto-config lang - why? why not?
DATASETS = { at:    { path: AT_DIR,    lang: 'de'}, ## domestic clubs
             de:    { path: DE_DIR,    lang: 'de'},
             en:    { path: EN_DIR,    lang: 'en'},
             es:    { path: ES_DIR,    lang: 'es'},
             it:    { path: IT_DIR,    lang: 'it'},
             fr:    { path: FR_DIR,    lang: 'fr'},
           }

##  used by json export/generate task
FOOTBALL_JSON_DIR = "#{OPENFOOTBALL_DIR}/football.json"



BUILD_DIR = "./build"

DATA_KEY = ENV['DATA'] || ENV['DATASET'] || 'all'     ## note: was 'worldcup' default DATA_KEY
puts "  using DATA_KEY >#{DATA_KEY}<"

DB_CONFIG = {
  adapter:   'sqlite3',
  database:  "#{BUILD_DIR}/#{DATA_KEY}.db"
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

DATASETS.each do |key,h|
  task :"read_#{key}" => :config do
    SportDb.read( h[:path] )
    ## SportDb.read( h[:path], '2019/20' )
  end
end

## note: :ru not working for now (fix date e.g. [])
task :read_all => DATASETS.keys.map {|key|:"read_#{key}" } do
end


desc 'build football.db from scratch (default)'
task :build => [:clean, :create, :"read_#{DATA_KEY}"] do
  puts 'Done.'
end




require_relative 'scripts/json'    ## pulls in gen_json helper


task :json => :config  do       ## for in-memory depends on all for now - ok??
  out_root = if debug?
               BUILD_DIR
             else
               FOOTBALL_JSON_DIR
             end

  # gen_json( 'at.1', out_root: out_root )   ###  todo/fix: check for stages starting in 2018/19
  # gen_json( 'at.2', out_root: out_root )

  gen_json( 'de.1',   out_root: out_root )
  gen_json( 'de.2',   out_root: out_root )
  gen_json( 'de.3',   out_root: out_root )

  gen_json( 'eng.1',  out_root: out_root )
  gen_json( 'eng.2',  out_root: out_root )
  gen_json( 'eng.3',  out_root: out_root )
  gen_json( 'eng.4',  out_root: out_root )

  gen_json( 'es.1',   out_root: out_root )
  gen_json( 'es.2',   out_root: out_root )

  gen_json( 'it.1',   out_root: out_root )

  gen_json( 'fr.1',   out_root: out_root )
end



desc 'print logs (stored in db)'
task :logs => :env do
  puts "db logs (#{LogDb::Models::Log.count})"
  LogDb::Models::Log.order(:id).each do |log|
     puts "  [#{log.level}] #{log.ts}  - #{log.msg}"
  end
end


############
#  push github
task :push do
    ## todo/fix:
    ##  check if any changes (only push if changes commits - how??)

    path = FOOTBALL_JSON_DIR
    msg  = "auto-update week #{Date.today.cweek}"

    puts "Dir.getwd: #{Dir.getwd}"
    Dir.chdir( path ) do
      ## trying to update
      puts ''
      puts "###########################################"
      puts "## trying to commit & push repo in path >#{path}<"
      puts "Dir.getwd: #{Dir.getwd}"
      result = system( "git status" )
      pp result
      result = system( "git add ." )
      pp result
      result = system( %Q{git commit -m "#{msg}"} )
      pp result
      result = system( "git push" )
      pp result
      ## todo: check return code
    end
    puts "Dir.getwd: #{Dir.getwd}"
end
