# Todos


- [ ]

     yorobot -  do NOT load flowfile on adduser - why? why not?
        and do NOT load flowfile on init {owner}/{repo}
                      by default pick-up  GITHUB_REPOSITORY - why? why not?
         add to yorobot built-in
         new  init / bootstrap / checkout / clone ??  {owner}/{repo}

-- circular -  NOT actions/setup-ruby  still requires checked out Gemfile/Gemfile.lock
     thus, no point in trying to checkout (bootstrap) repo
     because  yorobot is not yet operational (installed with bundle install!!!)

maybe try ai query with:

```
hello. i am designing a new workflow. can you suggest good names for a workflow step  for the  setup/clone (with depth=1) of the initial github repo  if the workflow has steps such as adduser, clone, publish, etc.?


yes, maybe keep with github and use simply checkout !!!

adduser
checkout    ###   check if .ssh present otherwise use https:// - why? why not?
```


- [ ]  use setup  for   adduser & init/bootstrap/clone/cloneself
         find a good name for the workflow step

- [ ]  add to flowfile --depth=1 option for clone
         how?
- [ ]  add a debug/dump step e.g.  yo dump/debug/???
          to dump all built-in steps


- [ ] to bin/yo  autoadd/autouse  bundle/setup or such
       - no longer

- [ ] add a yo env   step command for debugging!!
      output  pwd and ruby load path etc.




```
flow-lite/1.1.0 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]
shell-lite/0.0.1 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]
gitti/0.6.1 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]
monofile/0.2.4 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]
gitti-backup/0.4.1 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]
monos/1.1.1 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]
yorobot/2026.6.14 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]

[flow] pwd: C:/sports/yorobot/football.json
[flow]   assume local (dev) setup for testing
[flow] Mono.root: C:/sites                          !!!!!!!
[flow] loading >./flowfile.rb<...
```


- [ ] default  Mono.root to   /sports if exits first
                      and     /sites
       note - MOPATH gets ignored for now!!!!
- [ ] always use File.expand_path  on Mono.root=(path)
           e.g.  auto-expands  /sports  on windows to c:/sports