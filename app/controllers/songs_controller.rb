class SongsController < ApplicationController

  get '/songs' do
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs' do
    @song = Song.create(params[:song])
    #adds song to library of creator
    UserSong.create(song_id: @song.id, user_id: current_user.id)
    redirect to "/songs/#{@song.id}"
  end

  get '/songs/:id' do
    @song = Song.find(params[:id])
    erb :'/songs/show'
  end

  patch '/songs/:id' do
    redirect to "/songs/#{@song.id}"
  end

end
