require 'gitti'
require 'gitti/sync'


include Gitti    ## lets you use Git, GitError, etc.


# assuming your working folder is `yorobot/football.json`
# where you have cloned this very repo

sync = GitSync.new( '../..' )

repos = GitRepoSet.from_file( './repos.yml' )
sync.sync( repos )
