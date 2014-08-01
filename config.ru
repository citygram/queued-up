require 'dotenv'
require 'rack/contrib/not_found'
require 'sidekiq/web'
require 'sinatra'

Dotenv.load

auth_name = ENV.fetch('BASIC_AUTH_NAME')
auth_password = ENV.fetch('BASIC_AUTH_PASSWORD')

use Rack::Auth::Basic, 'Restricted Area' do |name, password|
  name == auth_name && password == auth_password
end

use Sidekiq::Web

run Rack::NotFound.new('./404.html')
