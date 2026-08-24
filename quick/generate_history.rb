###################
#  to run use:
#    $ ruby quick/generate_history.rb
#       or
#    $ yo -r ./boot_history json DEBUG=t



require_relative 'helper'



# '2025-26',
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

#    'uefa.cl'  =>  ['champions-league',  'cl'],

    ## add africa
#    'ma.1'  =>  [['world', 'africa/morocco']],
#    'eg.1'  =>  [['world', 'africa/egypt']],
#    'dz.1'  =>  [['world', 'africa/algeria']],

    ## add north-america
#    'mx.1'  =>  [['world', 'north-america/mexico']],

    ## add pacific
#    'au.1'    =>  [['world', 'pacific/australia']],
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

   _genjson( DATASETS,    seasons: %w[2025/26], debug: debug )
   _genjson( DATASETS_II, seasons: %w[2025],    debug: debug )
end



if __FILE__ == $0
  genjson( debug: true )
  puts "bye"
end
