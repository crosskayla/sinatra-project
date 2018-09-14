class UsersController < ApplicationController

  get '/users/edit' do
    if signed_in?
      @user = current_user
      erb :'/users/edit'
    else
      flash[:message] = "You must be signed in to edit your user page."
      redirect '/failure'
    end
  end

  get '/users/:id' do
    if signed_in?
      @user = User.find(params[:id])
      erb :'/users/show'
    else
      flash[:message] = "You must be signed in to view user pages."
      redirect '/failure'
    end
  end

  patch '/users/edit/:id' do
    @user = User.find(params[:id])

    #users can only edit themselves:
    if @user == current_user
      #removes songs unless selected on form
      @user.songs.each do |song|
        @user.songs.delete(song) unless params[:song_ids].include?(song.id)
      end

      #adds songs if selected on form & not already in user songs
      params[:song_ids].each do |id|
        @song = Song.find(id)
        @user.songs << @song unless @user.songs.include?(@song)
      end

      @user.save
      flash[:message] = "Successfully edited your library."
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "You can only edit your own account."
      redirect '/failure'
    end
  end

  patch '/users/addone/:id' do
    @user = User.find(params[:id])
    @song = Song.find(params[:song_id])

    #users can only edit themselves:
    if @user == current_user
      #adds song
      @user.songs << @song unless @user.songs.include?(@song)
      @user.save
      flash[:message] = "Successfully added song to your library."
      redirect "/songs/#{@song.id}"
    else
      flash[:message] = "You can only edit your own account."
      redirect '/failure'
    end
  end

end
