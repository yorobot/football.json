
##################
#  sync   (that is, clone repo if new or fast-forward if repo exists)
#
#  todo/check:  add back shallow "fast-clone" with depth: 1 support - why? why not?


### todo/change
##  rename step to [:setup,:up] - why? why not?

step [:sync, :clone] do
  #############
  ### "deep" standard/ regular clone
  [
    # 'logs@yorobot',
    'football.json@openfootball',
  ].each do |repo|
    Mono.sync( repo )
  end

  ######
  ### shallow "fast clone" - to be done
  ###  use https:// instead of ssh - why? why not?
  [
    'england@openfootball',
    'deutschland@openfootball',
    'italy@openfootball',
    'espana@openfootball',
    'europe@openfootball'
    'austria@openfootball',
    'champions-league@openfootball',
  ].each do |repo|
    Mono.sync( repo )   ## was: Mono.clone( repo, depth: 1 )
  end
end



########################
#  publish   (that is, commit & push if any changes)
step [:publish, :pub, :push] do
  ## todo/fix: get utc date - possible?
  today = Date.today
  msg  = "auto-update week #{today.cweek} / day #{today.yday} / on #{today.strftime('%A, %B %-d, %Y')}"

  Mono.open( 'football.json@openfootball' ) do |proj|
    puts "check for changes (to commit & push) in >#{Dir.pwd}<:"
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    else
      puts "  - no changes -"
    end
  end
end
