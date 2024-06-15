require "sportdb/readers"

$LOAD_PATH.unshift( "../sport.db.more/sportdb-exporters/lib" )
require "sportdb/exporters"


DB_CONFIG = {
  adapter:   'sqlite3',
  database:  "../../sportdb/sport.db/build/euro2024.db"
}

SportDb.connect( DB_CONFIG )


SportDb::Model::Event.order( :id ).each do |event|
    puts "    #{event.key} | #{event.league.key} - #{event.league.name} | #{event.season.key}"
end


SportDb::JsonExporter.export_euro( 'euro', out_root: './tmp/json' )

puts "bye"


__END__

euro.1960 | euro - Euro | 1960
euro.1964 | euro - Euro | 1964
euro.1968 | euro - Euro | 1968
euro.2008 | euro - Euro | 2008
euro.2012 | euro - Euro | 2012
euro.2016 | euro - Euro | 2016
euro.2021 | euro - Euro | 2021
euro.2024 | euro - Euro | 2024