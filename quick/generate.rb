###################
#  to run use:
#    $ ruby quick/generate.rb


require 'sportdb/quick'

# '2024-25',
datasets = {
    'en.1'  =>  ['england',            '1-premierleague',    'Premier League'],
    'en.2'  =>  ['england',            '2-championship',    'Championship'],
    'es.1'  =>  ['espana',             '1-liga',          'Primera División'],
    'de.1'  =>  ['deutschland',        '1-bundesliga',     'Bundesliga'],
    'de.2'  =>  ['deutschland',        '2-bundesliga2',    '2. Bundesliga'],
    'it.1'  =>  ['italy',              '1-seriea',        'Serie A'],
    'fr.1'  =>  [['europe', 'france'], '1-ligue1',        'Ligue 1'],

    'at.1'  =>  ['austria',                 '1-bundesliga',   'Bundesliga'],
    'nl.1'  =>  [['europe', 'netherlands'], '1-eredivisie',   'Eredivisie'],
    'pt.1'  =>  [['europe', 'portugal'],    '1-primeiraliga', 'Primeira Liga'],

    'uefa.cl'  =>  ['champions-league',  'cl',            'UEFA Champions League'],
}

pp datasets


# seasons = %w[2020/21 2021/22 2022/23 2023/24 2024/25]
seasons = %w[2024/25]


root_dir = '../../openfootball'

out_dir  = './tmp'
# out_dir  = '../../openfootball/football.json'

seasons.each do |season|
    season = Season( season )   ## convert to season obj
    datasets.each do |key, ((repo,repo_path),basename,name)|
      path  = "#{root_dir}/#{repo}"
      path   +=  "/#{repo_path}"  if repo_path
      path +=  "/#{season.to_path}"  ## auto-add season path
      path +=  "/#{basename}.txt"

       puts path

        if File.exist?( path )
          matches = SportDb::QuickMatchReader.read( path )
          pp matches[0,1]
          data = {
              'name'  => "#{name} #{season}",
              'matches' => matches.map {|match| match.as_json }  # convert to json
          }
          write_json( "#{out_dir}/#{season.to_path}/#{key}.json", data )
        end
    end
end


puts "bye"