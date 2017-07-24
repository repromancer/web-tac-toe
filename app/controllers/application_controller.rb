require './config/environment'

class ApplicationController < Sinatra::Base

  configure do

    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, ENV['TIC_TAC_SECRET']

    use Rack::Flash

  end

  helpers AuthenticationUtils

  before /\/(?!signup|login|clickbait).+/ do
    screen_unauthorized_users
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :'index.html'
    end
  end

  get "/clickbait" do
    flash[:message] = "Please sign up to play! :)"
    redirect '/signup'
  end

end
