class SongsController < ApplicationController
  
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  
  get '/songs' do 
    @song = Song.all 
    erb :'/songs/index'
  end 
  
  get '/songs/new' do 
    erb :'songs/new'
  end 
  
  get '/songs/:slug' do 
    
    @song = Song.find{|song| song.slug == params[:slug]}
    erb :'/songs/show'
    
  end 
  
  post '/songs' do 
    
    @song =Song.create(:name => params["name"])
    @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
    @song.genre_ids = params[:genres]
    @song.save
    erb :"/songs/show" , locals:{message: "successfuly created song."}
  end 
  
  get '/songs/:slug/edit' do 
    @song = Song.find {|song| song.slug == params[:slug]}
    erb :'/songs/edit'
  end 
  
  patch '/songs/:slug' do 
    @song =Song.find {|song| song.slug == params[:slug]}
    @song.name =params["Name"]
    @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
    
    @genres =Genre.find(params[:genre])
    @song.song_genres.clear 
    
    @genres.each do |genre|
     
     song_genres =SongGenre.new(:song => @song, :genre => genre)
     song_genres.save 
     
   end 
   @song.save 
   
  # flash[:message] ="song successfuly updated"
  # redirect "/songs/#{@song.slug}"
   
   erb :"/songs/show" , locals:{message: "song successfuly updated."}
   
 end 
    
        
  
  end
