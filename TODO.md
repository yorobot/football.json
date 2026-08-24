# Todos

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