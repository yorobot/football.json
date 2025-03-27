###
#  collect league keys and seasons
#    from dir to possibly regenerate
#
#   to run use:
#      $ ruby sandbox/collect.rb

require 'cocos'


rootdir = '/sports/openfootball/football.json'


paths = Dir.glob( "#{rootdir}/**/*.json" )


## note - exclude package.json and others
    ## note: if pattern includes directory add here
    ##     (otherwise move to more "generic" datafile) - why? why not?
    ##   update - note include/allow dot (.) too
    ##     BUT NOT as first character!!! (e.g. exclude .confg.txt !!!)
    ##               e.g. 2024-25/at.1.txt
    ##                        change to at_1 or uefa_cl or such - why? why not?
    MATCH_RE = %r{ (?: 
                      (?: ^|/ )      # beginning (^) or beginning of path (/)
                       (?<season>
                             \d{4}-\d{2}
                           | \d{4} 
                       ) 
                       /
                       
                       (?<code>
                          [a-z0-9][a-z0-9_.-]* 
                        )
                       \.json$ 
                    )
                }x




pp paths
puts "  #{paths.size} candidate(s)"


specs = []
paths.each do |path|
  if m=MATCH_RE.match( path )
    specs << [path, { 'season' => m[:season],
                     'code'   => m[:code] } 
            ] 
  end
end

pp specs
puts "  #{specs.size} datafile(s)"


dataset = {}
specs.each do |path, h|
    season = h['season']
    code   = h['code']

## exlclude 2025 and 2024-25
    next if ['2025', '2024-25'].include?(season)

    league =  dataset[code] ||= []
    league << season
end

pp dataset


puts "bye"