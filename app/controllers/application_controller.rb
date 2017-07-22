require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    # NEEDS PERSISTENT SECRET
    # set :session_secret, ENV.fetch('SESSION_SECRET') { Sysrandom.hex(64) }
    enable :sessions

    use Rack::Flash
  end

  helpers AuthenticationUtils

  before /\/(?!signup|login).+/ do
    binding.pry
    screen_unauthorized_users
  end

  get "/" do
    erb :'index.html'
  end

end
