class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  # set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  enable :sessions
  set :session_secret, "password_security"

  helpers do
    def signed_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
