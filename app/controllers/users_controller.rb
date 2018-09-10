class UsersController < ApplicationController
  enable :sessions
  set :session_secret, "password_security"

  get '/' do
    if !signed_in?
      erb :index
    else
      redirect "/users/#{current_user.id}"
    end
  end

  get '/signin' do
    erb :signin
  end

  get '/signup' do
    erb :signup
  end

  get '/failure' do
    erb :failure
  end

  get '/signout' do
    session.clear
    redirect "/"
  end

  post '/signup' do
    if params.values.any?{|v| v == "" }
      redirect "/failure"
    else
      @user = User.create(params)
      #logs user in automatically
      session[:user_id] = @user.id
      redirect "/users/edit"
    end
  end

  post '/signin' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/edit"
    else
      redirect "/failure"
    end
  end

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

  post '/users/edit/:id' do

    @user = User.find(params[:id])
    #users can only edit themselves:
    if @user == current_user
      params[:song_ids].each do |id|
        UserSong.create(song_id: id, user_id: @user.id)
      end
      redirect "/users/#{@user.id}"
    else
      redirect '/signin'
    end
  end

  helpers do
    def signed_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
