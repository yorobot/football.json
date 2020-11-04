
PROJECTS = {
  ####################
  #  checkout skripts (auto-update machinery)
  'yorobot': [
    'football.json',      ## incl. self
    'sport.db.more',      ## JsonExporter
    'logs'  ],

  ###############
  #  use latest sportdb machinery (from source)
  'sportdb': [
   'sport.db',
   'football.db' ],

   'rubycoco': [
    'git',
    'monos' ],
}

projects PROJECTS



## note: see config.rb for DATASETS definition; gets (auto-required)
DATASETS.each do |_,dataset|
  project 'openfootball', dataset[:name]
end

## todo/check:  rename to SUPPORT_DATASETS or such - why? why not?
MORE_DATASETS = {
  'openfootball': [
     ## add basics
     'leagues',
     'clubs',
     ## add (auto-generated) json datasets
     'football.json' ]
}

projects MORE_DATASETS
