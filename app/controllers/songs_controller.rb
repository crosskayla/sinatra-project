class SongsController < ApplicationController

  get '/songs' do
    erb :'/songs/index'
  end

  get '/songs/new' do
    if signed_in?
      erb :'/songs/new'
    else
      flash[:message] = "You must be signed in to create a song."
      redirect to "/failure"
    end
  end

  post '/songs' do
    @song = Song.create(params[:song])
    if @song && current_user
      #adds song to library of creator
      current_user.songs << @song
      flash[:message] = "Song created successfully!"
      redirect to "/songs/#{@song.id}"
    else
      flash[:message] = "There was an error creating that song."
      redirect to "/users/#{current_user.id}"
    end
  end

  get '/songs/:id' do
    if signed_in?
      @song = Song.find(params[:id])
      erb :'/songs/show'
    else
      flash[:message] = "Error: you must be signed in to view individual song information."
      redirect to '/songs'
    end
  end

  get '/songs/:id/edit' do
    @song = Song.find(params[:id])
    erb :'/songs/edit'
  end

  patch '/songs/:id' do
    @song = Song.find(params[:id])
    if @song.id == current_user.id
      @song.update(params[:song])
      flash[:message] = "Song updated successfully!"
    else
      flash[:message] = "Error: you can only edit songs you created."
    end
    redirect to "/songs/#{@song.id}"
  end

  delete '/songs/:id' do
    @song = Song.find(params[:id])
    @song_name = @song.name
    if @song.created_by == current_user.id
      @song.destroy
      flash[:message] = "#{@song_name} was successfully deleted."
    else
      flash[:message] = "Error: you can only delete songs you created."
    end
    redirect to "/songs"
  end

end
