###################
#  to run use:
#    $ ruby quick/generate.rb



unless defined?( Mono )
  ## for testing - setup Mono with root in /tmp
  require 'mono'
  puts "pwd: #{Dir.pwd}"

  if Dir.exist?( '/sports' )
    Mono.root = '/sports'     ## use local (dev) setup for testing flow steps
    puts "[flow]   assume local (dev) setup for testing"
  else
    Mono.root = Dir.pwd
 ## [flow] pwd: /home/runner/work/football.json/football.json
 ## [flow] Mono.root: /home/runner/work/football.json/football.json

    ## for debugging print / walk mono (source) tree
    Mono.walk
  end

  ## use working dir as root? or change to home dir ~/ or ~/mono - why? why not?
  ## Mono.root = "#{Dir.pwd}/tmp"
  puts "Mono.root: #{Mono.root}"
end




require 'sportdb/quick'


# '2024-25',
datasets = {
    'en.1'  =>  ['england',            '1-premierleague'],
    'en.2'  =>  ['england',            '2-championship'],
    'es.1'  =>  ['espana',             '1-liga'],
    'de.1'  =>  ['deutschland',        '1-bundesliga'],
    'de.2'  =>  ['deutschland',        '2-bundesliga2'],
    'it.1'  =>  ['italy',              '1-seriea'],
    'fr.1'  =>  [['europe', 'france'], '1-ligue1'],

    'at.1'  =>  ['austria',                 '1-bundesliga'],
    'at.2'  =>  ['austria',                 '2-liga2'],
    'nl.1'  =>  [['europe', 'netherlands'], '1-eredivisie'],
    'pt.1'  =>  [['europe', 'portugal'],    '1-primeiraliga'],

    'uefa.cl'  =>  ['champions-league',  'cl'],
}

pp datasets


# seasons = %w[2020/21 2021/22 2022/23 2023/24 2024/25]
seasons = %w[2024/25]


# root_dir = '../../openfootball'
root_dir = "#{Mono.root}/openfootball"


# out_dir  = './tmp'
out_dir  = "#{Mono.root}/openfootball/football.json"


seasons.each do |season|
    season = Season( season )   ## convert to season obj
    datasets.each do |key, ((repo,repo_path),basename,name)|
      path  = "#{root_dir}/#{repo}"
      path   +=  "/#{repo_path}"  if repo_path
      path +=  "/#{season.to_path}"  ## auto-add season path
      path +=  "/#{basename}.txt"

       puts path

        if File.exist?( path )
          txt = read_text( path )
          quick = SportDb::QuickMatchReader.new( txt )
          matches = quick.parse
          name    = quick.league_name   ## quick hack - get league+season via league_name

          pp matches[0,1]
          data = {
              'name'    => name,
              'matches' => matches.map {|match| match.as_json }  # convert to json
          }
          write_json( "#{out_dir}/#{season.to_path}/#{key}.json", data )
        end
    end
end


puts "bye"