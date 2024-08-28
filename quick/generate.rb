###################
#  to run use:
#    $ ruby quick/generate.rb


require 'sportdb/quick'

# '2024-25',
datasets = {
    'en.1'  =>  ['england',            '1-premierleague', 'Premier League'],
    'es.1'  =>  ['espana',             '1-liga',          'Primera División'],
    'de.1'  =>  ['deutschland',        '1-bundesliga',    'Bundesliga'],
    'it.1'  =>  ['italy',              '1-seriea',        'Serie A'],
    'fr.1'  =>  [['europe', 'france'], '1-ligue1',        'Ligue 1'],
}

pp datasets

BASE = 'https://raw.githubusercontent.com/openfootball'

seasons = %w[2024/25 2023/24]

seasons.each do |season|
    season = Season( season )   ## convert to season obj
    datasets.each do |key, ((repo,path),basename,name)|
      url  = "#{BASE}/#{repo}"
      url += "/master"    ## auto-add branch
      url +=  "/#{path}"  if path
      url +=  "/#{season.to_path}"  ## auto-add season path
      url +=  "/#{basename}.txt"

    puts url

    res = Webclient.get( url )
    sleep( 2 )

    if res.status.ok?
        matches = SportDb::QuickMatchReader.parse( res.text )
        pp matches[0,1]
        data = {
            'name'  => "#{name} #{season}",
            'matches' => matches.map {|match| match.as_json }  # convert to json
        }
        write_json( "./tmp/#{season.to_path}/#{key}.json", data )
    else
        puts "!! HTTP ERROR - #{res.status.code} #{res.status.message}"
        exit 1
    end
end
end


puts "bye"