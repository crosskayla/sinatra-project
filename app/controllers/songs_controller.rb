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

  get '/songs/:id/edit' do
    @song = Song.find(params[:id])
    if @song.created_by == current_user.id
      erb :'/songs/edit'
    else
      erb :'/failure'
    end
  end

  patch '/songs/:id' do
    @song = Song.find(params[:id])
    @song.update(params[:song])
    redirect to "/songs/#{@song.id}"
  end

  delete '/songs/:id' do
    @song = Song.find(params[:id])
    if @song.created_by == current_user.id
      @song.destroy
      redirect to "/songs"
    else
      erb :'/failure'
    end
  end

end
