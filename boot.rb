## hack: use "local" dev monoscript too :-) for now
$LOAD_PATH.unshift( 'C:/Sites/sportdb/sport.db/monos/lib' )

## note: use the local version of sportdb-source gem
require 'mono/sportdb'
Mono.setup   # setup load path


#### todo/fix: move all boot code/stuff for sharing/reuse to mono/sportdb!!!

$RUBYLIBS_DEBUG = true

def debug?
  value = ENV['DEBUG']
  if value && ['true', 't', 'yes', 'y'].include?( value.downcase )
    true
  else
    false
  end
end



SPORTDB_DIR      = "#{Mono.root}/sportdb"     # path to libs
OPENFOOTBALL_DIR = "#{Mono.root}/openfootball"

# $LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/football.db/footballdb-leagues/lib" ))
# $LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/football.db/footballdb-clubs/lib" ))

require 'sportdb/readers'

### add exporters (e.g. json)
require 'sportdb/exporters'


## use (switch to) latest "external" datasets
SportDb::Import.config.leagues_dir = "#{OPENFOOTBALL_DIR}/leagues"
SportDb::Import.config.clubs_dir   = "#{OPENFOOTBALL_DIR}/clubs"


