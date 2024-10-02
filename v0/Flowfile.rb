
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
  ### shallow "fast clone" - support libraries
  ###  use https:// instead of ssh - why? why not?
  [
    'sport.db.more@yorobot',
  ].each do |repo|
    Mono.sync( repo )   ## was: Mono.clone( repo, depth: 1 )
  end


  names = DATASETS.map { |key,h| h[:name] }
  # e.g. like [
  #  'england',
  #  'deutschland',
  #  'espana',
  #  'italy',
  #  'france',
  #  'austria',
  #  'mexico']
  pp names

  ###################
  ### shallow "fast" clone (no commit/push possible); use depth 1
  ###  use https:// instead of ssh - why? why not?
  ###    no need for commits - just read-only ok
  names += [ ## add basic setup too
            'leagues',
            'clubs',
           ]
  names.each do |name|
    Mono.sync( "#{name}@openfootball" )  ## was: Mono.clone( "#{name}@openfootball", depth: 1 )
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




#################
#  more
step :build do
  build( DATASETS )
end


step :stats do
  connect
  SportDb.tables   ## print some stats

  SportDb::Model::Event.order( :id ).each do |event|
     puts "    #{event.key} | #{event.league.key} - #{event.league.name} | #{event.season.key}"
  end

  ## dump logs if any
  puts "db logs (#{LogDb::Models::Log.count})"
  LogDb::Models::Log.order(:id).each do |log|
    puts "  [#{log.level}] #{log.ts}  - #{log.msg}"
  end
end




step :json do
  out_root =  if debug?
                './o'
              else
                Mononame.real_path( 'football.json@openfootball' )
              end

  connect   ## note: requires database connection

  [
    'at.1',  # Austria
    'at.2',
    'at.cup',

    'de.1',  # Germany • Deutschland
    'de.2',
    'de.3',
    'de.cup',

    'eng.1',  # England
    'eng.2',
    'eng.3',
    'eng.4',

    'es.1',  # Spain • España
    'es.2',

    'it.1',  # Italy
    'it.2',

    ## from europe/ datasets
    'fr.1',  # France
    'fr.2',

    'sco.1', # Scotland

    'nl.1',  # Netherlands
    'be.1',  # Belgium
    'pt.1',  # Portugal

    'ch.1',  # Switzerland
    'ch.2',

    'cz.1',  # Czech Republic
    'hu.1',  # Hungary

    'gr.1',  # Greece
    'tr.1',  # Turkey
    'tr.2',

    'ru.1',  # Russia
    'ru.2',

    ## from south-america/ datasets
    'ar.1',  # Argentina
    'br.1',  # Brazil

    ## from world/ datasets
    'cn.1',  # China
    'jp.1',  # Japan
    'au.1',  # Australia

    ###################
    ## more
    'mx.1',  # Mexico

    #########
    ## clubs int'l  (incl. group/group phase)
    'uefa.cl.quali',   # Champions League Quali(fications)
    'uefa.cl',         # Champions League
  ].each do |league|
    SportDb::JsonExporter.export( league, out_root: out_root )
  end
end

