require 'sinatra/base'
class SongsController < Sinatra::Base
  enable :sessions
  
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }


   get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end



end 