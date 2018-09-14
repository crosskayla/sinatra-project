class UsersController < ApplicationController

  get '/users/edit' do
    if signed_in?
      @user = current_user
      erb :'/users/edit'
    else
      redirect '/failure'
    end
  end

  get '/users/:id' do
    if signed_in?
      @user = User.find(params[:id])
      erb :'/users/show'
    else
      redirect '/signin'
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
      redirect "/users/#{@user.id}"
    else
      redirect '/signin'
    end
  end

end
