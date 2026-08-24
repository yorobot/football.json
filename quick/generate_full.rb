###################
#  to run use:
#    $ ruby quick/generate_full.rb
#       or
#    $ yo -r ./quick/generate_full json DEBUG=t



require_relative 'helper'



# '2025-26',
DATASETS = {
    'en.1-full'  =>  ['england',            '1-premierleague-full'],

    'de.1-full'  =>  ['deutschland',        '1-bundesliga-full'],

    'at.1-full'  =>  ['austria',            '1-bundesliga-full'],
  }






pp DATASETS


def genjson( debug: debug? )
  # seasons = %w[2020/21 2021/22 2022/23 2023/24 2024/25]

   _genjson( DATASETS,    seasons: %w[2025/26], debug: debug )
end



if __FILE__ == $0
  genjson( debug: true )
  puts "bye"
end
