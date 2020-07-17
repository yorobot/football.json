$RUBYLIBS_DEBUG = true

def debug?
  value = ENV['DEBUG']
  if value && ['true', 't', 'yes', 'y'].include?( value.downcase )
    true
  else
    false
  end
end



SPORTDB_DIR      = '../../sportdb'     # path to libs

## note: use the local version of sportdb gems
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-langs/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-formats/lib" ))

# $LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/football.db/footballdb-leagues/lib" ))
# $LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/football.db/footballdb-clubs/lib" ))

$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-config/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-models/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-sync/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-readers/lib" ))



require 'sportdb/readers'

OPENFOOTBALL_DIR = "../../openfootball"

## use (switch to) latest "external" datasets
SportDb::Import.config.leagues_dir = "#{OPENFOOTBALL_DIR}/leagues"
SportDb::Import.config.clubs_dir   = "#{OPENFOOTBALL_DIR}/clubs"


### add exporters (e.g. json)
$LOAD_PATH.unshift( File.expand_path( "../sport.db.more/sportdb-exporters/lib" ))
require 'sportdb/exporters'