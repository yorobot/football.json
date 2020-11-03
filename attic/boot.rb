####
## note: to test boot setup use:
##   ruby ./boot.rb


## hack: use "local" dev monoscript too :-) for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/monos/lib' )

## note: use the local version of sportdb-source gem
require 'sportdb/setup'
SportDb::Boot.setup   # setup load path



require 'sportdb/readers'
require 'sportdb/exporters'   ### add exporters (e.g. json)


##  fix constant warning - why? why not?
## ./boot.rb:15: warning: already initialized constant OPENFOOTBALL_DIR
## /rubycoco/monos/lib/sportdb/setup.rb:105: warning: previous definition of OPENFOOTBALL_DIR was here

OPENFOOTBALL_DIR = "#{SportDb::Boot.root}/openfootball"

## use (switch to) latest "external" datasets
SportDb::Import.config.leagues_dir = "#{OPENFOOTBALL_DIR}/leagues"
SportDb::Import.config.clubs_dir   = "#{OPENFOOTBALL_DIR}/clubs"


