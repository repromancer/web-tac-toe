ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

### a crude attempt at a slightly
### more secure session_secret
ENV['TIC_TAC_SECRET'] ||= begin
  file = 'config/super_secret'
  if File.exist?(file) && IO.read(file).length == 128
    IO.read(file)
  else
    IO.write(file, Sysrandom.hex(64))
    IO.read(file)
  end
end
###
###

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'