unless defined?( Mono )
  ## for testing - setup Mono with root in /tmp
  require 'mono'
  puts "pwd: #{Dir.pwd}"
  ## use working dir as root? or change to home dir ~/ or ~/mono - why? why not?
  ## Mono.root = "#{Dir.pwd}/tmp"
  puts "Mono.root: #{Mono.root}"

  ## Mono.walk  ## for debugging print / walk mono (source) tree
end



require "sportdb/readers"

$LOAD_PATH.unshift( Monopath.real_path( "sportdb-exporters/lib@yorobot/sport.db.more" ))
puts "path=>#{Monopath.real_path('sportdb-exporters/lib@yorobot/sport.db.more')}<"
require "sportdb/exporters"


## use (switch to) latest "external" datasets
SportDb::Import.config.leagues_dir = Mononame.real_path( "leagues@openfootball" )
SportDb::Import.config.clubs_dir   = Mononame.real_path( "clubs@openfootball" )




#########################################
# built-in support code for flowfile


require './config'    ## e.g. datasets and seasons to include etc.


BUILD_DIR = "./build"
FileUtils.mkdir_p( BUILD_DIR )  ## make sure path exists

DB_CONFIG = {
  adapter:   'sqlite3',
  database:  "#{BUILD_DIR}/all.db"
}




def connect
  ## todo/fix:  exit if database does NOT exist already!!!
  SportDb.connect( DB_CONFIG )

  logger = LogUtils::Logger.root
  ## log all warns, errors, fatals to db
  LogDb.setup
  logger.warn "connect - #{Time.now}"  # say hello; log to db (warn level min)
  ## use DEBUG=t or DEBUG=f
  logger.level =  :debug     # :info
end



def build( datasets=DATASETS )
  ## todo/fix:  warn/exit if database exists already!!!
  SportDb.connect( DB_CONFIG )
  SportDb.create_all

  logger = LogUtils::Logger.root
  ## log all warns, errors, fatals to db
  LogDb.setup
  logger.warn "build - #{Time.now}"  # say hello; log to db (warn level min)
  ## use DEBUG=t or DEBUG=f
  logger.level =  :debug     # :info


  datasets.each do |key,h|
       start_time = Time.now   ## todo: use Timer? t = Timer.start / stop / diff etc. - why? why not?

       ## SportDb.read( h[:path] )
       ## note: only incl. latest season for now
       SportDb.read( Mononame.real_path( "#{h[:name]}@openfootball"), season: SEASON_LATEST )

       end_time = Time.now
       diff_time = end_time - start_time
       puts "read_#{key}: done in #{diff_time} sec(s)"
  end
end

