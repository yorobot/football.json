# football.json (Auto-Update) Scripts



## Step 0 - Install Required Ruby Libraries / Gems

Get a copy of this repo (use git clone or such)
and than run:

```
$ bundle install
```

to install all required ruby libraries / gems
(listed in the [`Gemfile`](Gemfile)).


New to ruby, bundler & friends?
See [Bundler »](https://bundler.io/)




## Step 1 - Sync / Pull / Clone All Datasets

```
$ yo sync
```

resulting in something like:

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


## Step 2 - Build sport.db From the Sources

Use

```
$ yo -r ./boot build
```

to build a fresh database copy (`./build/all.db`) from scratch / zero.


## Step 3 - Generate football.json Datasets

For testing / debugging use:

```
$ yo -r ./boot json DEBUG=t
```

that will write all datasets into the `./o` debug output directory.
And use

```
$ yo -r ./boot json
```

for writing into the `openfootball/football.json`
(release output / production) directory.




## Questions? Comments?

Send them along to the
[Open Sports & Friends Forum/Mailing List](http://groups.google.com/group/opensport).
Thanks!

