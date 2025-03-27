###################
#  to run use:
#    $ ruby sandbox/generate.rb


require 'sportdb/quick'



LEAGUES = {
    'en.1'  =>  ['england',            '1-premierleague'],
    'en.2'  =>  ['england',            '2-championship'],
    'en.3'  =>  ['england',            '3-league1'],
    'en.4'  =>  ['england',            '4-league2'],

    'es.1'  =>  ['espana',             '1-liga'],
    'es.2'  =>  ['espana',             '2-liga2'],

    'de.1'   =>  ['deutschland',        '1-bundesliga'],
    'de.2'   =>  ['deutschland',        '2-bundesliga2'],
    'de.3'   =>  ['deutschland',        '3-liga3'],
    'de.cup'  =>  ['deutschland',        'cup'],

    'it.1'  =>  ['italy',              '1-seriea'],
    'it.2'  =>  ['italy',              '2-serieb'],

    'at.1'    =>  ['austria',            '1-bundesliga'],
    'at.2'    =>  ['austria',            '2-liga2'],
    'at.cup'  =>  ['austria',            'cup'],

    
    'fr.1'  =>  [['europe', 'france']],
    'fr.2'  =>  [['europe', 'france']],

    'nl.1'  =>  [['europe', 'netherlands']],
    'be.1'  =>  [['europe', 'belgium']],
    'pt.1'  =>  [['europe', 'portugal']],
    'sco.1' =>  [['europe', 'scotland']],
    'gr.1'  =>  [['europe', 'greece']],
    'tr.1'  =>  [['europe', 'turkey']],
    'tr.2'  =>  [['europe', 'turkey']],

     'ch.1' =>  [['europe', 'switzerland']],
     'ch.2' =>  [['europe', 'switzerland']],

     'cz.1'  =>  [['europe', 'czech-republic']],
     'hu.1'  =>  [['europe', 'hungary']],
     'ru.1'  =>  [['europe', 'russia']],
     'ru.2'  =>  [['europe', 'russia']],
    

    'uefa.cl'  =>  ['champions-league',  'cl'],

    ## add africa
    'ma.1'  =>  [['world', 'africa/morocco']],
    'eg.1'  =>  [['world', 'africa/egypt']],
    'dz.1'  =>  [['world', 'africa/algeria']],

    ## add north-america
    'mx.1'  =>  [['world', 'north-america/mexico']],

    ## add pacific
    'au.1'    =>  [['world', 'pacific/australia']],

    'mls'    => [['world',          'north-america/major-league-soccer' ]],
    'ar.1'   => [['south-america',  'argentina']], 
    'br.1'   => [['south-america',  'brazil']],
    'br.2'   => [['south-america',  'brazil']],
    'co.1'   => [['south-america',  'colombia']], 
    'copa.l' => [['south-america',  'copa-libertadores' ]],

    'jp.1'   => [['world',   'asia/japan']],
    'cn.1'   => [['world',   'asia/china']],
}


pp LEAGUES



DATASET = {"at.1"=>
  ["2010-11",
   "2011-12",
   "2012-13",
   "2013-14",
   "2014-15",
   "2015-16",
   "2016-17",
   "2017-18",
   "2018-19",
   "2019-20",
   "2020-21",
   "2021-22",
   "2022-23",
   "2023-24"],
 "at.2"=>
  ["2010-11",
   "2011-12",
   "2012-13",
   "2013-14",
   "2014-15",
   "2015-16",
   "2016-17",
   "2017-18",
   "2018-19",
   "2019-20",
   "2020-21"],
 "de.1"=>
  ["2010-11",
   "2011-12",
   "2012-13",
   "2013-14",
   "2014-15",
   "2015-16",
   "2016-17",
   "2017-18",
   "2018-19",
   "2019-20",
   "2020-21",
   "2021-22",
   "2022-23",
   "2023-24"],
 "en.1"=>
  ["2010-11",
   "2011-12",
   "2012-13",
   "2013-14",
   "2014-15",
   "2015-16",
   "2016-17",
   "2017-18",
   "2018-19",
   "2019-20",
   "2020-21",
   "2021-22",
   "2022-23",
   "2023-24"],
 "en.2"=>
  ["2010-11",
   "2011-12",
   "2012-13",
   "2013-14",
   "2014-15",
   "2015-16",
   "2018-19",
   "2019-20",
   "2020-21",
   "2021-22",
   "2022-23",
   "2023-24"],
 "en.3"=>["2010-11", "2011-12", "2012-13", "2013-14", "2014-15", "2015-16", "2018-19", "2019-20", "2020-21"],
 "en.4"=>["2010-11", "2011-12", "2012-13", "2013-14", "2014-15", "2015-16", "2018-19", "2019-20", "2020-21"],
 "uefa.cl"=>["2011-12", "2012-13", "2013-14", "2014-15", "2015-16", "2016-17", "2017-18", "2018-19", "2019-20"],
 "de.2"=>
  ["2012-13",
   "2013-14",
   "2014-15",
   "2015-16",
   "2016-17",
   "2017-18",
   "2018-19",
   "2019-20",
   "2020-21",
   "2021-22",
   "2022-23",
   "2023-24"],
 "es.1"=>
  ["2012-13",
   "2013-14",
   "2014-15",
   "2015-16",
   "2016-17",
   "2017-18",
   "2018-19",
   "2019-20",
   "2020-21",
   "2021-22",
   "2022-23",
   "2023-24"],
 "es.2"=>["2012-13", "2013-14", "2014-15", "2015-16", "2016-17", "2017-18", "2018-19", "2019-20", "2020-21"],
 "it.1"=>
  ["2013-14",
   "2014-15",
   "2015-16",
   "2016-17",
   "2017-18",
   "2018-19",
   "2019-20",
   "2020-21",
   "2021-22",
   "2022-23",
   "2023-24"],
 "it.2"=>["2013-14", "2014-15", "2015-16", "2016-17", "2017-18", "2018-19", "2019-20", "2020-21"],
 "ch.1"=>["2014-15", "2018-19", "2019-20", "2020-21"],
 "de.3"=>["2014-15", "2015-16", "2016-17", "2017-18", "2018-19", "2019-20", "2020-21"],
 "fr.1"=>
  ["2014-15", "2015-16", "2016-17", "2017-18", "2018-19", "2019-20", "2020-21", "2021-22", "2022-23", "2023-24"],
 "fr.2"=>["2014-15", "2015-16", "2016-17", "2017-18", "2018-19", "2019-20", "2020-21"],
 "ar.1"=>["2018-19", "2019-20"],
 "at.cup"=>["2018-19", "2019-20", "2020-21"],
 "au.1"=>["2018-19"],
 "be.1"=>["2018-19", "2019-20", "2020-21"],
 "cz.1"=>["2018-19", "2020-21"],
 "de.cup"=>["2018-19", "2019-20", "2020-21"],
 "gr.1"=>["2018-19", "2019-20", "2020-21"],
 "hu.1"=>["2018-19", "2020-21"],
 "mx.1"=>["2018-19", "2019-20", "2020-21"],
 "nl.1"=>["2018-19", "2019-20", "2020-21", "2021-22", "2022-23", "2023-24"],
 "pt.1"=>["2018-19", "2019-20", "2020-21", "2021-22", "2022-23", "2023-24"],
 "ru.1"=>["2018-19", "2019-20", "2020-21"],
 "sco.1"=>["2018-19", "2019-20", "2020-21"],
 "tr.1"=>["2018-19", "2019-20", "2020-21"],
 "br.1"=>["2019", "2020"],
 "cn.1"=>["2019", "2020"],
 "jp.1"=>["2019", "2020"],
 "ch.2"=>["2019-20", "2020-21"],
 "ru.2"=>["2019-20"],
 "tr.2"=>["2019-20"]}



### check if config available for league in dataset

DATASET.each do |code, seasons|
   puts "==> #{code} - #{seasons}"
   config = LEAGUES[code]
   if config.nil?
     puts "!!! no config found"
     exit 1
   else
      pp config
   end
end




def genjson( datasets, debug: true )

  root_dir = "/sports/openfootball"

  out_dir =  if debug
               './tmp'
             else
               "#{root_dir}/football.json"
             end
  
  datasets.each do |code, seasons| 
     config = LEAGUES[code]
     if config.nil?
      puts "!!! no config found"
      exit 1
     end 

     (repo,repo_path), basename = config
     puts "#{code} -- #{repo}, #{repo_path}, #{basename}"
     
     seasons = seasons.sort.reverse

     seasons.each do |season|
        season = Season( season )   ## convert to season obj

        path  = "#{root_dir}/#{repo}"
        path   +=  "/#{repo_path}"  if repo_path

###
##  quick fix
     if code == 'at.2' && season <= Season('2017/18') 
         basename = '2-liga1'
     end


        if  basename.nil?   ## assume flat outpath style for seasons
                            ##    e.g.   2024-25_fr1.txt 
          path +=  "/#{season.to_path}"  ## auto-add season path
          path +=  "_#{code.gsub( '.', '' )}.txt"
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
          write_json( "#{out_dir}/#{season.to_path}/#{code}.json", data )
        else
            puts "!! missing #{code} #{season} - datafile >#{path}<"
            exit 1
        end
      end
  end
end



genjson( DATASET, debug: false )

puts "bye"

__END__

{"at.1"=>{"2017/18"=>{:names=>["Bundesliga 2017/2018 » Spielplan"]}},
 "at.2"=>
  {"2010/11"=>{:names=>["2. Liga 2010/2011 » Spielplan"]},
   "2011/12"=>{:names=>["2. Liga 2011/2012 » Spielplan"]},
   "2012/13"=>{:names=>["2. Liga 2012/2013 » Spielplan"]},
   "2013/14"=>{:names=>["2. Liga 2013/2014 » Spielplan"]},
   "2014/15"=>{:names=>["2. Liga 2014/2015 » Spielplan"]},
   "2015/16"=>{:names=>["2. Liga 2015/2016 » Spielplan"]},
   "2016/17"=>{:names=>["2. Liga 2016/2017 » Spielplan"]},
   "2017/18"=>{:names=>["2. Liga 2017/2018 » Spielplan"]}},
 "de.1"=>
  {"2010/11"=>{:names=>["Bundesliga 2010/2011 » Spielplan"]},
   "2011/12"=>{:names=>["Bundesliga 2011/2012 » Spielplan"]},
   "2012/13"=>{:names=>["Bundesliga 2012/2013 » Spielplan"]},
   "2013/14"=>{:names=>["Bundesliga 2013/2014 » Spielplan"]},
   "2014/15"=>{:names=>["Bundesliga 2014/2015 » Spielplan"]},
   "2015/16"=>{:names=>["Bundesliga 2015/2016 » Spielplan"]},
   "2016/17"=>{:names=>["Bundesliga 2016/2017 » Spielplan"]},
   "2017/18"=>{:names=>["Bundesliga 2017/2018 » Spielplan"]},
   "2018/19"=>{:names=>["Bundesliga 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Bundesliga 2019/2020 » Spielplan"]}},
 "uefa.cl"=>
  {"2011/12"=>{:names=>["Champions League 2011/2012 » Spielplan"]},
   "2012/13"=>{:names=>["Champions League 2012/2013 » Spielplan"]},
   "2013/14"=>{:names=>["Champions League 2013/2014 » Spielplan"]},
   "2014/15"=>{:names=>["Champions League 2014/2015 » Spielplan"]},
   "2015/16"=>{:names=>["Champions League 2015/2016 » Spielplan"]},
   "2016/17"=>{:names=>["Champions League 2016/2017 » Spielplan"]},
   "2017/18"=>{:names=>["Champions League 2017/2018 » Spielplan"]},
   "2018/19"=>{:names=>["Champions League 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Champions League 2019/2020 » Spielplan"]}},
 "de.2"=>
  {"2012/13"=>{:names=>["2. Bundesliga 2012/2013 » Spielplan"]},
   "2013/14"=>{:names=>["2. Bundesliga 2013/2014 » Spielplan"]},
   "2014/15"=>{:names=>["2. Bundesliga 2014/2015 » Spielplan"]},
   "2015/16"=>{:names=>["2. Bundesliga 2015/2016 » Spielplan"]},
   "2016/17"=>{:names=>["2. Bundesliga 2016/2017 » Spielplan"]},
   "2017/18"=>{:names=>["2. Bundesliga 2017/2018 » Spielplan"]},
   "2018/19"=>{:names=>["2. Bundesliga 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["2. Bundesliga 2019/2020 » Spielplan"]}},
 "es.1"=>
  {"2012/13"=>{:names=>["Primera División 2012/2013 » Spielplan"]},
   "2013/14"=>{:names=>["Primera División 2013/2014 » Spielplan"]},
   "2014/15"=>{:names=>["Primera División 2014/2015 » Spielplan"]},
   "2015/16"=>{:names=>["Primera División 2015/2016 » Spielplan"]},
   "2016/17"=>{:names=>["Primera División 2016/2017 » Spielplan"]},
   "2017/18"=>{:names=>["Primera División 2017/2018 » Spielplan"]},
   "2018/19"=>{:names=>["Primera División 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Primera División 2019/2020 » Spielplan"]}},
 "es.2"=>
  {"2012/13"=>{:names=>["Segunda División 2012/2013 » Spielplan"]},
   "2013/14"=>{:names=>["Segunda División 2013/2014 » Spielplan"]},
   "2014/15"=>{:names=>["Segunda División 2014/2015 » Spielplan"]},
   "2015/16"=>{:names=>["Segunda División 2015/2016 » Spielplan"]},
   "2016/17"=>{:names=>["Segunda División 2016/2017 » Spielplan"]},
   "2017/18"=>{:names=>["Segunda División 2017/2018 » Spielplan"]},
   "2018/19"=>{:names=>["Segunda División 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Segunda División 2019/2020 » Spielplan"]}},
 "it.1"=>
  {"2013/14"=>{:names=>["Serie A 2013/2014 » Spielplan"]},
   "2014/15"=>{:names=>["Serie A 2014/2015 » Spielplan"]},
   "2015/16"=>{:names=>["Serie A 2015/2016 » Spielplan"]},
   "2016/17"=>{:names=>["Serie A 2016/2017 » Spielplan"]},
   "2017/18"=>{:names=>["Serie A 2017/2018 » Spielplan"]},
   "2018/19"=>{:names=>["Serie A 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Serie A 2019/2020 » Spielplan"]}},
 "it.2"=>
  {"2013/14"=>
    {:names=>
      ["Serie B 2013/2014 » Spielplan",
       "Serie B 2013/2014 Abstieg » Spielplan",
       "Serie B 2013/2014 Aufstieg » Spielplan"]},
   "2014/15"=>
    {:names=>
      ["Serie B 2014/2015 » Spielplan",
       "Serie B 2014/2015 Abstieg » Spielplan",
       "Serie B 2014/2015 Aufstieg » Spielplan"]},
   "2015/16"=>
    {:names=>
      ["Serie B 2015/2016 » Spielplan",
       "Serie B 2015/2016 Abstieg » Spielplan",
       "Serie B 2015/2016 Aufstieg » Spielplan"]},
   "2016/17"=>{:names=>["Serie B 2016/2017 » Spielplan", "Serie B 2016/2017 Aufstieg » Spielplan"]},
   "2017/18"=>
    {:names=>
      ["Serie B 2017/2018 » Spielplan",
       "Serie B 2017/2018 Abstieg » Spielplan",
       "Serie B 2017/2018 Aufstieg » Spielplan"]},
   "2018/19"=>
    {:names=>
      ["Serie B 2018/2019 » Spielplan",
       "Serie B 2018/2019 Abstieg » Spielplan",
       "Serie B 2018/2019 Aufstieg » Spielplan"]},
   "2019/20"=>
    {:names=>
      ["Serie B 2019/2020 » Spielplan",
       "Serie B 2019/2020 Abstieg » Spielplan",
       "Serie B 2019/2020 Aufstieg » Spielplan"]}},
 "ch.1"=>
  {"2014/15"=>{:names=>["Super League 2014/2015 » Spielplan"]},
   "2018/19"=>{:names=>["Super League 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Super League 2019/2020 » Spielplan"]},
   "2020/21"=>{:names=>["Super League 2020/2021 » Spielplan"]}},
 "de.3"=>
  {"2014/15"=>{:names=>["3. Liga 2014/2015 » Spielplan"]},
   "2015/16"=>{:names=>["3. Liga 2015/2016 » Spielplan"]},
   "2016/17"=>{:names=>["3. Liga 2016/2017 » Spielplan"]},
   "2017/18"=>{:names=>["3. Liga 2017/2018 » Spielplan"]},
   "2018/19"=>{:names=>["3. Liga 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["3. Liga 2019/2020 » Spielplan"]}},
 "fr.1"=>
  {"2014/15"=>{:names=>["Ligue 1 2014/2015 » Spielplan"]},
   "2015/16"=>{:names=>["Ligue 1 2015/2016 » Spielplan"]},
   "2016/17"=>{:names=>["Ligue 1 2016/2017 » Spielplan"]},
   "2017/18"=>{:names=>["Ligue 1 2017/2018 » Spielplan"]},
   "2018/19"=>{:names=>["Ligue 1 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Ligue 1 2019/2020 » Spielplan"]}},
 "fr.2"=>
  {"2014/15"=>{:names=>["Ligue 2 2014/2015 » Spielplan"]},
   "2015/16"=>{:names=>["Ligue 2 2015/2016 » Spielplan"]},
   "2016/17"=>{:names=>["Ligue 2 2016/2017 » Spielplan"]},
   "2017/18"=>{:names=>["Ligue 2 2017/2018 » Spielplan"]},
   "2018/19"=>{:names=>["Ligue 2 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Ligue 2 2019/2020 » Spielplan"]}},
 "be.1"=>
  {"2018/19"=>{:names=>["Pro League 2018/2019 » Spielplan", "Pro League 2018/2019 Playoff I » Spielplan"]},
   "2019/20"=>{:names=>["Pro League 2019/2020 » Spielplan"]},
   "2020/21"=>
    {:names=>
      ["Pro League 2020/2021 » Spielplan",
       "Pro League 2020/2021 Championship » Spielplan",
       "Pro League 2020/2021 Europe » Spielplan"]}},
 "cz.1"=>
  {"2018/19"=>
    {:names=>
      ["1. fotbalová liga 2018/2019 » Spielplan",
       "1. fotbalová liga 2018/2019 Abstieg » Spielplan",
       "1. fotbalová liga 2018/2019 Europa League » Spielplan",
       "1. fotbalová liga 2018/2019 Meisterschaft » Spielplan"]},
   "2020/21"=>{:names=>["1. fotbalová liga 2020/2021 » Spielplan"]}},
 "de.cup"=>
  {"2018/19"=>{:names=>["DFB-Pokal 2018/2019 » Spielplan"]}, "2019/20"=>{:names=>["DFB-Pokal 2019/2020 » Spielplan"]}},
 "gr.1"=>
  {"2018/19"=>{:names=>["Super League 2018/2019 » Spielplan"]},
   "2019/20"=>
    {:names=>
      ["Super League 2019/2020 » Spielplan",
       "Super League 2019/2020 Abstieg » Spielplan",
       "Super League 2019/2020 Meisterschaft » Spielplan"]},
   "2020/21"=>
    {:names=>
      ["Super League 2020/2021 » Spielplan",
       "Super League 2020/2021 Abstieg » Spielplan",
       "Super League 2020/2021 Meisterschaft » Spielplan"]}},
 "hu.1"=>{"2018/19"=>{:names=>["NB I 2018/2019 » Spielplan"]}, "2020/21"=>{:names=>["NB I 2020/2021 » Spielplan"]}},
 "nl.1"=>
  {"2018/19"=>{:names=>["Eredivisie 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Eredivisie 2019/2020 » Spielplan"]}},
 "pt.1"=>
  {"2018/19"=>{:names=>["Primeira Liga 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Primeira Liga 2019/2020 » Spielplan"]}},
 "ru.1"=>
  {"2018/19"=>{:names=>["Premier Liga 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Premier Liga 2019/2020 » Spielplan"]},
   "2020/21"=>{:names=>["Premier Liga 2020/2021 » Spielplan"]}},
 "sco.1"=>
  {"2018/19"=>{:names=>["Premiership 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["Premiership 2019/2020 » Spielplan"]},
   "2020/21"=>{:names=>["Premiership 2020/2021 » Spielplan"]}},
 "tr.1"=>
  {"2018/19"=>{:names=>["SüperLig 2018/2019 » Spielplan"]},
   "2019/20"=>{:names=>["SüperLig 2019/2020 » Spielplan"]},
   "2020/21"=>{:names=>["SüperLig 2020/2021 » Spielplan"]}},
 "ch.2"=>
  {"2019/20"=>{:names=>["Challenge League 2019/2020 » Spielplan"]},
   "2020/21"=>{:names=>["Challenge League 2020/2021 » Spielplan"]}},
 "ru.2"=>{"2019/20"=>{:names=>["Premier Liga 2019/2020 » Spielplan"]}},
 "tr.2"=>{"2019/20"=>{:names=>["1. Lig 2019/2020 » Spielplan", "1. Lig 2019/2020 Playoffs » Spielplan"]}}}