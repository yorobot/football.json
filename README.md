# football.json Scripts


## Step 1 - Sync / Pull / Clone All Datasets

**Alternative I - Use Git Command Line**

```
$ mkdir yorobot
$ cd    yorobot
$ git clone https://github.com/yorobot/football.json

$ cd ..
$ mkdir openfootball
$ cd    openfootball
$ git clone https://github.com/openfootball/england
$ git clone https://github.com/openfootball/deutschland
$ git clone https://github.com/openfootball/austria
$ git clone https://github.com/openfootball/espana
$ git clone https://github.com/openfootball/italy
# ...
$ git clone https://github.com/openfootball/football.json
```

resulting in:

```
/yorobot
   /football.json
/openfootball
   /england
   /deutschland
   /austria
   /espana
   /italy
   # ...
   /football.json
```


**Alternative II - Use the `mono` Setup Script  (Recommended)**

Use

```
$ mono up
```

to setup (sync e.g. clone or pull with fast forward merge) all repos (configured in [`monorepo.yml`](monorepo.yml))
to the monorepo / mono source tree (root) folder
(defaulting to `/sites` for now).

Find out more about [the `mono` (short `mo`) command line tool »](https://github.com/sportdb/sport.db/tree/master/monos)




## Step 2 - Build sport.db From the Sources

Use

```
$ rake build
```

to build a fresh copy from scratch / zero.


## Step 3 - Generate football.json Datasets

For testing / debugging use:

```
$ rake json DEBUG=t
```

that will write all datasets into the `./build` directory.
And use

```
$ rake json
```

for writing into the `openfootball/football.json` directory.



## Questions? Comments?

Send them along to the
[Open Sports & Friends Forum/Mailing List](http://groups.google.com/group/opensport).
Thanks!

