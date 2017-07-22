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

  before /\/(?!signup|login).+/ do
    screen_unauthorized_users
  end

  get "/" do
    erb :'index.html'
  end

end
