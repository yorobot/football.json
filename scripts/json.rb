

LEAGUE_TO_BASENAME = {
  'eng.1' => 'en.1',
  'eng.2' => 'en.2',
  'eng.3' => 'en.3',
  'eng.4' => 'en.4',

  'world' => 'worldcup',
  ## 'cl'    => 'cl',    ## keep cl as is :-)
}


def build_clubs( event )
  clubs = []
  event.teams.each do |team|
    clubs << { name: team.name,
               code: team.code }
  end

  data = {
   name:  event.name,
   clubs: clubs
  }

  data
end

def build_matches( event )
  rounds = []
  event.rounds.each do |round|
    matches = []
    round.matches.each do |match|
      matches << { date:  match.date.strftime( '%Y-%m-%d'),
                   team1: match.team1.name,
                   team2: match.team2.name,
                   score1: match.score1,
                   score2: match.score2 }
    end

    rounds << { name:    round.name,
                matches: matches }
  end

  data = {
    name:   event.name,
    rounds: rounds
  }

  data
end



def gen_json( league_key, out_root: )

  puts "find league >#{league_key}<"
  league = SportDb::Model::League.find_by!( key: league_key )

  league.events.each do |event|
     puts "** event:"
     pp event.name
     pp event.season
     pp event.league
     puts "teams.count: #{event.teams.count}"
     puts "rounds.count: #{event.rounds.count}"
     puts "matches.count: #{event.matches.count}"

     data_clubs = build_clubs( event )
     ## pp data_clubs

     data_matches = build_matches( event )
     ## pp data_matches

     ## build path e.g.
     ##  2014-15/at.1.clubs.json

     ##  -- check for remapping (e.g. add .1); if not found use league key as is
     league_basename = LEAGUE_TO_BASENAME[ event.league.key ] || event.league.key

     season_basename = event.season.name.sub('/', '-')  ## e.g. change 2014/15 to 2014-15


     out_dir   = "#{out_root}/#{season_basename}"
     ## make sure folders exist
     FileUtils.mkdir_p( out_dir ) unless Dir.exists?( out_dir )

     File.open( "#{out_dir}/#{league_basename}.clubs.json", 'w:utf-8' ) do |f|
       f.write JSON.pretty_generate( data_clubs )
     end

     File.open( "#{out_dir}/#{league_basename}.json", 'w:utf-8' ) do |f|
       f.write JSON.pretty_generate( data_matches )
     end
  end
end

