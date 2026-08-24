# Notes, Tips & Tricks

note - monos incl. a mono command-line tool!!!
try

```
$ mono -h

monofile/0.2.4 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]
shell-lite/0.0.1 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]
gitti/0.6.1 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]
gitti-backup/0.4.1 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]
monos/1.1.1 on Ruby 3.3.6 (2024-11-05) [x64-mingw-ucrt]

Usage: mono [options]
    -r, --require NAME
```

more tips
```

use MOPATH  to set mono root e.g.

set MOPATH=c:/sports

and try walk (debug) command eg.

$ mo walk

resulting in:

>c:/sports/openfootball< - level 2:
    repo #1  | austria              @ openfootball (c:/sports/openfootball)
    repo #2  | belgium              @ openfootball (c:/sports/openfootball)
    repo #3  | champions-league     @ openfootball (c:/sports/openfootball)
    repo #4  | club-worldcup        @ openfootball (c:/sports/openfootball)
    ...
    repo #28 | worldcup.json        @ openfootball (c:/sports/openfootball)
  28 repos(s), 29 dir(s), 0 warn(s)
...
```


more

```
  Mono.root = Dir.pwd

 [flow] pwd: /home/runner/work/football.json/football.json
 [flow] Mono.root: /home/runner/work/football.json/football.json

#  for debugging print / walk mono (source) tree
  Mono.walk

   >/home/runner/work/football.json/football.json/openfootball< - level 2:
    repo #1  | italy                @ openfootball (/home/runner/work/football.json/football.json/openfootball)
    repo #2  | austria              @ openfootball (/home/runner/work/football.json/football.json/openfootball)
    repo #3  | europe               @ openfootball (/home/runner/work/football.json/football.json/openfootball)
    repo #4  | football.json        @ openfootball (/home/runner/work/football.json/football.json/openfootball)
    repo #5  | champions-league     @ openfootball (/home/runner/work/football.json/football.json/openfootball)
    repo #6  | espana               @ openfootball (/home/runner/work/football.json/football.json/openfootball)
    repo #7  | england              @ openfootball (/home/runner/work/football.json/football.json/openfootball)
    repo #8  | deutschland          @ openfootball (/home/runner/work/football.json/football.json/openfootball)
  8 repos(s), 8 dir(s), 0 warn(s)
```




Mono.root: /sports

(i) on startup

```
check LOAD_PATH:
["/ruby33/lib/ruby/site_ruby/3.3.0",
 "/ruby33/lib/ruby/site_ruby/3.3.0/x64-ucrt",
 "/ruby33/lib/ruby/site_ruby",
 "/ruby33/lib/ruby/vendor_ruby/3.3.0",
 "/ruby33/lib/ruby/vendor_ruby/3.3.0/x64-ucrt",
 "/ruby33/lib/ruby/vendor_ruby",
 "/ruby33/lib/ruby/3.3.0",
 "/ruby33/lib/ruby/3.3.0/x64-mingw-ucrt"]
```

(ii) after `require 'mono'`  -- ruby auto-adds ../gems/... entries
```
check LOAD_PATH:
["/ruby33/lib/ruby/gems/3.3.0/gems/monofile-0.2.4/lib",
 "/ruby33/lib/ruby/gems/3.3.0/gems/shell-lite-0.0.1/lib",
 "/ruby33/lib/ruby/gems/3.3.0/gems/gitti-0.6.1/lib",
 "/ruby33/lib/ruby/gems/3.3.0/gems/gitti-backup-0.4.1/lib",
 "/ruby33/lib/ruby/gems/3.3.0/gems/monos-1.1.1/lib",
 "/ruby33/lib/ruby/site_ruby/3.3.0",
 "/ruby33/lib/ruby/site_ruby/3.3.0/x64-ucrt",
 "/ruby33/lib/ruby/site_ruby",
 "/ruby33/lib/ruby/vendor_ruby/3.3.0",
 "/ruby33/lib/ruby/vendor_ruby/3.3.0/x64-ucrt",
 "/ruby33/lib/ruby/vendor_ruby",
 "/ruby33/lib/ruby/3.3.0",
 "/ruby33/lib/ruby/3.3.0/x64-mingw-ucrt"]
```

(iii)   before `require 'fbtxt/document'`

```
check LOAD_PATH:
["/sports/sportdb/sport.db.v2/document/lib",
 "/sports/sportdb/sport.db.v2/parser/lib",
 "/sports/sportdb/sport.db.v2/lexer/lib",
 "/ruby33/lib/ruby/gems/3.3.0/gems/monofile-0.2.4/lib",
 "/ruby33/lib/ruby/gems/3.3.0/gems/shell-lite-0.0.1/lib",
 "/ruby33/lib/ruby/gems/3.3.0/gems/gitti-0.6.1/lib",
 "/ruby33/lib/ruby/gems/3.3.0/gems/gitti-backup-0.4.1/lib",
 "/ruby33/lib/ruby/gems/3.3.0/gems/monos-1.1.1/lib",
 "/ruby33/lib/ruby/site_ruby/3.3.0",
 "/ruby33/lib/ruby/site_ruby/3.3.0/x64-ucrt",
 "/ruby33/lib/ruby/site_ruby",
 "/ruby33/lib/ruby/vendor_ruby/3.3.0",
 "/ruby33/lib/ruby/vendor_ruby/3.3.0/x64-ucrt",
 "/ruby33/lib/ruby/vendor_ruby",
 "/ruby33/lib/ruby/3.3.0",
 "/ruby33/lib/ruby/3.3.0/x64-mingw-ucrt"]
```
