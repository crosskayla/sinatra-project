class UsersController < ApplicationController

  get '/' do
    erb :index
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

  post '/signup' do
    if params.values.any?{|v| v.empty?}
      redirect "/failure"
    else
      User.create(params)
      #logs user in automatically
      session[:user_id] = @user.id
      redirect "/songs"
    end
  end

  post '/signin' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/songs"
    else
      redirect "/failure"
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
