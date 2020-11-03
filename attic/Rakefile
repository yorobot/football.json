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
AT_DIR        = "#{OPENFOOTBALL_DIR}/austria"
DE_DIR        = "#{OPENFOOTBALL_DIR}/deutschland"
EN_DIR        = "#{OPENFOOTBALL_DIR}/england"
ES_DIR        = "#{OPENFOOTBALL_DIR}/espana"
IT_DIR        = "#{OPENFOOTBALL_DIR}/italy"
FR_DIR        = "#{OPENFOOTBALL_DIR}/france"
WORLD_DIR     = "#{OPENFOOTBALL_DIR}/world"   # incl. netherlands, portugal, switzerland, turkey, etc.

BR_DIR        = "#{OPENFOOTBALL_DIR}/brazil"
MX_DIR        = "#{OPENFOOTBALL_DIR}/mexico"
EUROPE_CL_DIR = "#{OPENFOOTBALL_DIR}/europe-champions-league"

DATASETS = {
             at:    { path: AT_DIR }, ## domestic clubs
             de:    { path: DE_DIR },
             en:    { path: EN_DIR },
             es:    { path: ES_DIR },
             it:    { path: IT_DIR },
             fr:    { path: FR_DIR },
             world: { path: WORLD_DIR },

             mx:    { path: MX_DIR },
             br:    { path: BR_DIR },
            ## note: reserve cl for country code for Chile!! - why? why not?
             europe_cl:  { path: EUROPE_CL_DIR },
}

##  used by json export/generate task
FOOTBALL_JSON_DIR = "#{OPENFOOTBALL_DIR}/football.json"



BUILD_DIR = "./build"
OUT_DIR   = "./o"        ## output dir for testing/debugging - note: NOT used for release only for debug (rename to DEBUG_OUT_DIR or such - why? why not?)
TMP_DIR   = "./tmp"


DATA_KEY = ENV['DATA'] || ENV['DATASET'] || 'all'     ## note: was 'worldcup' default DATA_KEY
puts "  using DATA_KEY >#{DATA_KEY}<"

DB_CONFIG = {
  adapter:   'sqlite3',
  database:  "#{BUILD_DIR}/#{DATA_KEY}.db"
}



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
     start_time = Time.now   ## todo: use Timer? t = Timer.start / stop / diff etc. - why? why not?

     ## SportDb.read( h[:path] )
     ## note: only incl. latest season for now
     latest = ['2018/19', '2019',
               '2019/20', '2020',
               '2020/21']
     ## for all start with 2010/11 season for now
     all    = ['2010/11',
               '2011/12',
               '2012/13',
               '2013/14',
               '2014/15',
               '2015/16',
               '2016/17',
               '2017/18',
               '2018/19', '2019',
               '2019/20', '2020']
     SportDb.read( h[:path], season: latest )

     SportDb.tables   ## print some stats

     ## dump logs if any
     puts "db logs (#{LogDb::Models::Log.count})"
     LogDb::Models::Log.order(:id).each do |log|
        puts "  [#{log.level}] #{log.ts}  - #{log.msg}"
     end

     end_time = Time.now
     diff_time = end_time - start_time
     puts "read_#{key}: done in #{diff_time} sec(s)"
  end
end


## note: :ru not working for now (fix date e.g. [])
task :read_all => DATASETS.keys.map {|key|:"read_#{key}" } do
end


desc 'build football.db from scratch (default)'
task :build => [:clean, :create, :"read_#{DATA_KEY}"] do
  puts 'Done.'
end




task :json => :config  do       ## for in-memory depends on all for now - ok??
  out_root = if debug?
               OUT_DIR   ## e.g. use './o'  -- was: BUILD_DIR (./build)
             else
               FOOTBALL_JSON_DIR
             end

  SportDb::JsonExporter.export( 'at.1',   out_root: out_root )   ###  todo/fix: check for stages starting in 2018/19
  SportDb::JsonExporter.export( 'at.2',   out_root: out_root )
  SportDb::JsonExporter.export( 'at.cup', out_root: out_root )

  SportDb::JsonExporter.export( 'de.1',   out_root: out_root )
  SportDb::JsonExporter.export( 'de.2',   out_root: out_root )
  SportDb::JsonExporter.export( 'de.3',   out_root: out_root )
  SportDb::JsonExporter.export( 'de.cup', out_root: out_root )


  SportDb::JsonExporter.export( 'eng.1',  out_root: out_root )
  SportDb::JsonExporter.export( 'eng.2',  out_root: out_root )
  SportDb::JsonExporter.export( 'eng.3',  out_root: out_root )
  SportDb::JsonExporter.export( 'eng.4',  out_root: out_root )

  SportDb::JsonExporter.export( 'es.1',   out_root: out_root )
  SportDb::JsonExporter.export( 'es.2',   out_root: out_root )

  SportDb::JsonExporter.export( 'it.1',   out_root: out_root )
  SportDb::JsonExporter.export( 'it.2',   out_root: out_root )

  SportDb::JsonExporter.export( 'fr.1',   out_root: out_root )
  SportDb::JsonExporter.export( 'fr.2',   out_root: out_root )

  SportDb::JsonExporter.export( 'ru.1',   out_root: out_root )
  SportDb::JsonExporter.export( 'ru.2',   out_root: out_root )

  ## from world/ datasets
  SportDb::JsonExporter.export( 'nl.1',   out_root: out_root ) # Netherlands

  SportDb::JsonExporter.export( 'be.1',   out_root: out_root ) # Belgium

  SportDb::JsonExporter.export( 'pt.1',   out_root: out_root ) # Portugal

  SportDb::JsonExporter.export( 'ch.1',   out_root: out_root ) # Switzerland
  SportDb::JsonExporter.export( 'ch.2',   out_root: out_root )

  SportDb::JsonExporter.export( 'cz.1',   out_root: out_root ) # Czech Republic

  SportDb::JsonExporter.export( 'hu.1',   out_root: out_root ) # Hungary

  SportDb::JsonExporter.export( 'gr.1',   out_root: out_root ) # Greece

  SportDb::JsonExporter.export( 'tr.1',   out_root: out_root ) # Turkey
  SportDb::JsonExporter.export( 'tr.2',   out_root: out_root )


  SportDb::JsonExporter.export( 'sco.1',   out_root: out_root ) # Scotland

  SportDb::JsonExporter.export( 'ar.1',   out_root: out_root ) # Argentina

  SportDb::JsonExporter.export( 'cn.1',   out_root: out_root ) # China

  SportDb::JsonExporter.export( 'jp.1',   out_root: out_root ) # Japan

  SportDb::JsonExporter.export( 'au.1',   out_root: out_root ) # Australia


  ###################
  ## more
  SportDb::JsonExporter.export( 'mx.1',  out_root: out_root )

  SportDb::JsonExporter.export( 'br.1',  out_root: out_root )


  #########
  ## clubs int'l  (incl. group/group phase)
  SportDb::JsonExporter.export( 'uefa.cl.quali', out_root: out_root )
  SportDb::JsonExporter.export( 'uefa.cl',       out_root: out_root )
end



desc 'print logs (stored in db)'
task :logs => :env do
  puts "db logs (#{LogDb::Models::Log.count})"
  LogDb::Models::Log.order(:id).each do |log|
     puts "  [#{log.level}] #{log.ts}  - #{log.msg}"
  end
end


desc 'query database (for debugging)'
task :query => :env do
   team = SportDb::Model::Team.find_by!( name: 'FC Santa Coloma' )
   pp team
   puts team.matches.count
   pp team.matches
end



############
#  push github
task :push do
    path = FOOTBALL_JSON_DIR
    msg  = "auto-update week #{Date.today.cweek}"

    puts "Dir.getwd: #{Dir.getwd}"
    Gitti::GitProject.open( path ) do |proj|
      ## trying to update
      puts ''
      puts "###########################################"
      puts "## trying to commit & push repo in path >#{path}<"
      puts "Dir.getwd: #{Dir.getwd}"
      if proj.changes?
        proj.add( '.' )
        proj.commit( msg )
        proj.push
      else
        puts "  - no changes -"
      end
    end
    puts "Dir.getwd: #{Dir.getwd}"
end
