###################
#  to run use:
#    $ ruby quick/generate.rb
#       or
#    $ yo -r ./boot json DEBUG=t




unless defined?( Mono )
  ## for testing - setup Mono with root in /tmp
  require 'mono'
  puts "pwd: #{Dir.pwd}"
end

if Dir.exist?( '/sports' )
    Mono.root = '/sports'     ## use local (dev) setup for testing flow steps
    puts "[flow]   assume local (dev) setup for testing"
end

##  Mono.root = Dir.pwd
## [flow] pwd: /home/runner/work/football.json/football.json
## [flow] Mono.root: /home/runner/work/football.json/football.json

## for debugging print / walk mono (source) tree
##  Mono.walk
 ##  >/home/runner/work/football.json/football.json/openfootball< - level 2:
 ##   repo #1  | italy                @ openfootball (/home/runner/work/football.json/football.json/openfootball)
 ##   repo #2  | austria              @ openfootball (/home/runner/work/football.json/football.json/openfootball)
 ##   repo #3  | europe               @ openfootball (/home/runner/work/football.json/football.json/openfootball)
 ##   repo #4  | football.json        @ openfootball (/home/runner/work/football.json/football.json/openfootball)
 ##   repo #5  | champions-league     @ openfootball (/home/runner/work/football.json/football.json/openfootball)
 ##   repo #6  | espana               @ openfootball (/home/runner/work/football.json/football.json/openfootball)
 ##   repo #7  | england              @ openfootball (/home/runner/work/football.json/football.json/openfootball)
 ##   repo #8  | deutschland          @ openfootball (/home/runner/work/football.json/football.json/openfootball)
 ## 8 repos(s), 8 dir(s), 0 warn(s)



  ## use working dir as root? or change to home dir ~/ or ~/mono - why? why not?
  ## Mono.root = "#{Dir.pwd}/tmp"
  puts "Mono.root: #{Mono.root}"


require 'sportdb/quick'


# '2024-25',
DATASETS = {
    'en.1'  =>  ['england',            '1-premierleague'],
    'en.2'  =>  ['england',            '2-championship'],
    'en.3'  =>  ['england',            '3-league1'],
    'en.4'  =>  ['england',            '4-league2'],

    'es.1'  =>  ['espana',             '1-liga'],
    'es.2'  =>  ['espana',             '2-liga2'],

    'de.1'  =>  ['deutschland',        '1-bundesliga'],
    'de.2'  =>  ['deutschland',        '2-bundesliga2'],

    'it.1'  =>  ['italy',              '1-seriea'],
    'it.2'  =>  ['italy',              '2-serieb'],

    'at.1'  =>  ['austria',            '1-bundesliga'],
    'at.2'  =>  ['austria',            '2-liga2'],

    'fr.1'  =>  [['europe', 'france']],
    'fr.2'  =>  [['europe', 'france']],

    'nl.1'  =>  [['europe', 'netherlands']],
    'be.1'  =>  [['europe', 'belgium']],
    'pt.1'  =>  [['europe', 'portugal']],
    'sco.1' =>  [['europe', 'scotland']],
    'gr.1'  =>  [['europe', 'greece']],
    'tr.1'  =>  [['europe', 'turkey']],

    'uefa.cl'  =>  ['champions-league',  'cl'],

    ## add africa
    'ma.1'  =>  [['world', 'africa/morocco']],
    'eg.1'  =>  [['world', 'africa/egypt']],
    'dz.1'  =>  [['world', 'africa/algeria']],

    ## add north-america
    'mx.1'  =>  [['world', 'north-america/mexico']],

    ## add pacific
    'au.1'    =>  [['world', 'pacific/australia']],
  }


##########  
### season is calendar year
DATASETS_II = {
    'mls'    => [['world',          'north-america/major-league-soccer' ]],
    'ar.1'   => [['south-america',  'argentina']], 
    'br.1'   => [['south-america',  'brazil']],
    'br.2'   => [['south-america',  'brazil']],
    'co.1'   => [['south-america',  'colombia']], 
    'copa.l' => [['south-america',  'copa-libertadores' ]],

    'jp.1'   => [['world',   'asia/japan']],
    'cn.1'   => [['world',   'asia/china']],
}


pp DATASETS
pp DATASETS_II

def genjson( debug: debug? )
  # seasons = %w[2020/21 2021/22 2022/23 2023/24 2024/25]

  _genjson( DATASETS,    seasons: %w[2024/25], debug: debug )
  _genjson( DATASETS_II, seasons: %w[2025],    debug: debug )
end



def _genjson( datasets=DATASETS, seasons:,
                                 debug: debug? )

  root_dir = "#{Mono.root}/openfootball"

  out_dir =  if debug
               './tmp'
             else
               "#{Mono.root}/openfootball/football.json"
             end

  seasons.each do |season|
      season = Season( season )   ## convert to season obj
      datasets.each do |key, ((repo,repo_path),basename)|
        path  = "#{root_dir}/#{repo}"
        path   +=  "/#{repo_path}"  if repo_path

        if  basename.nil?   ## assume flat outpath style for seasons
                            ##    e.g.   2024-25_fr1.txt 
          basename = key.gsub( '.', '' )
          path +=  "/#{season.to_path}"  ## auto-add season path
          path +=  "_#{basename}.txt"
        else  ## add season as a directory AND use basename slug (not league code/key)
              ##          e.g. /2024-25/1-ligue1.txt
          path +=  "/#{season.to_path}"  ## auto-add season path
          path +=  "/#{basename}.txt"
        end


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
end




if __FILE__ == $0
  genjson( debug: true )
  puts "bye"
end

