
unless defined?( Mono )
  ## for testing - setup Mono with root in /tmp
  require 'mono'
  puts "pwd: #{Dir.pwd}"
end


if Dir.exist?( '/sports' )
    Mono.root = '/sports'     ## use local (dev) setup for testing flow steps
    puts "[flow]   assume local (dev) setup for testing"
end



## use working dir as root? or change to home dir ~/ or ~/mono - why? why not?
## Mono.root = "#{Dir.pwd}/tmp"
##
##  update comment above!!!
##   note -check if Mono.root defaults to  Dir.pwd (or use MOPATH env) !!!
puts "Mono.root: #{Mono.root}"




##  note:  quick hack
##   use local version of lexer/parser/documet
##     if available always use latest (local) source version
##
##  note -  cocos and seasons-formats gems/deps required in default env!!!

$LOAD_PATH.unshift( "#{Mono.root}/sportdb/sport.db.v2/lexer/lib" )
$LOAD_PATH.unshift( "#{Mono.root}/sportdb/sport.db.v2/parser/lib" )
$LOAD_PATH.unshift( "#{Mono.root}/sportdb/sport.db.v2/document/lib" )

puts "check LOAD_PATH:"
pp $LOAD_PATH

require 'fbtxt/document'




###############
## helper functions


def _genjson( datasets, seasons:,
                        debug: )

  root_dir = "#{Mono.root}/openfootball"

  out_dir =  if debug
               './tmp'
             else
               "#{Mono.root}/openfootball/football.json"
             end

  seasons.each do |season|
      season = Season( season )   ## convert to season obj
      datasets.each do |key, ((repo,repo_path),basename)|
        path  = "#{root_dir}/#{repo}"
        path   +=  "/#{repo_path}"  if repo_path

        if  basename.nil?   ## assume flat outpath style for seasons
                            ##    e.g.   2024-25_fr1.txt
          basename = key.gsub( '.', '' )
          path +=  "/#{season.to_path}"  ## auto-add season path
          path +=  "_#{basename}.txt"
        else  ## add season as a directory AND use basename slug (not league code/key)
              ##          e.g. /2024-25/1-ligue1.txt
          path +=  "/#{season.to_path}"  ## auto-add season path
          path +=  "/#{basename}.txt"
        end


        puts path

        if File.exist?( path )
          doc = Fbtxt::Document.read( path )

          pp doc.matches[0,1]
          data = {
              'name'    => doc.title,
              'matches' => doc.matches.as_json     # convert to json
          }


    ####################
    ## hack - use pretty_inspect for json pretty print
    txtjson =  data.pretty_inspect
    txtjson = txtjson.gsub( '=>', ': ' )
    ## puts txtjson[0,100] + "..."
    ## double check for syntax errors
    json = JSON.parse( txtjson )

          ## write_json( "#{out_dir}/#{season.to_path}/#{key}.json", data )
          write_text( "#{out_dir}/#{season.to_path}/#{key}.json", txtjson )
        end
      end
  end
end
