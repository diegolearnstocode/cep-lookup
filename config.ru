require './lookup'
# disable buffering for Heroku Logplex
$stdout.sync = true
run Sinatra::Application
