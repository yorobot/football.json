require "sportdb/readers"

$LOAD_PATH.unshift( "../sport.db.more/sportdb-exporters/lib" )
require "sportdb/exporters"


DB_CONFIG = {
  adapter:   'sqlite3',
  database:  "../../sportdb/sport.db/build/copa2024.db"
}

SportDb.connect( DB_CONFIG )


SportDb::Model::Event.order( :id ).each do |event|
    puts "    #{event.key} | #{event.league.key} - #{event.league.name} | #{event.season.key}"
end


SportDb::JsonExporter.export_copa( 'southamerica', out_root: './tmp/json/copa' )

puts "bye"


__END__

southamerica.2024 | southamerica - Copa América | 2024

