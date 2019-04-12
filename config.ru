require './lookup'
require 'pry-remote'
# disable buffering for Heroku Logplex
$stdout.sync = true
run Sinatra::Application
