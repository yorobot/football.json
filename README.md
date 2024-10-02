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


Try the yo (yorobot) command-line tool:

```
$ yo -h
```

resulting in:

```
Usage: yo [options] STEP
    -f, --file, --flowfile FILE      Read FILE as a flowfile.
    -r, --require NAME
    -d, --debug
```




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


## Step 2 - Generate football.json Datasets

For testing / debugging use:

```
$ yo -r ./boot json DEBUG=t
```

that will write all datasets into the `./tmp` debug output directory.
And use

```
$ yo -r ./boot json
```

for writing into the `openfootball/football.json`
(release output / production) directory.




## Questions? Comments?

Yes, you can. More than welcome.
See [Help & Support »](https://github.com/openfootball/help)

