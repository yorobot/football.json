##########################
## seasons
SEASON_LATEST = ['2018/19', '2019',
                 '2019/20', '2020',
                 '2020/21']

## for all start with 2010/11 season for now
SEASON_ALL    = ['2010/11',
                 '2011/12',
                 '2012/13',
                 '2013/14',
                 '2014/15',
                 '2015/16',
                 '2016/17',
                 '2017/18',
                 '2018/19', '2019',
                 '2019/20', '2020']



##########################
## datasets

DATASETS = {
  ## domestic clubs
  at:             { name: 'austria' },
  de:             { name: 'deutschland' },
  eng:            { name: 'england' },
  es:             { name: 'espana' },
  it:             { name: 'italy' },
  europe:         { name: 'europe' },   # incl. netherlands, portugal, switzerland, turkey, etc.
  ## note: reserve cl for country code for Chile!! - why? why not?
  europe_cl:      { name: 'europe-champions-league' },

  mx:             { name: 'mexico' },
  south_america:  { name: 'south-america' },
  world:          { name: 'world' },

  ### national (selection) teams
  euro:           { name: 'euro-cup' },
  worldcup:       { name: 'world-cup' },
}

