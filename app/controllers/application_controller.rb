class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  # set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  enable :sessions
  set :session_secret, "password_security"
  register Sinatra::Flash

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
      #logs user in automatically and allows them to select songs
      session[:user_id] = @user.id
      redirect "/users/edit"
    end
  end

  post '/signin' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      #redirects to user page
      redirect "/users/#{@user.id}"
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
