# initialize bundler
require 'bundler'
Bundler.require(:default)
require 'dotenv'
Dotenv.load

use Rack::ReverseProxy do
  # Forward the path /api/*
  reverse_proxy /^\/api(\/.*)$/, "http://0.0.0.0:#{ENV['API_PORT']}" + '$1'
end

# you can comment this line to disable live-reload
use Inesita::LiveReload

# run inesita server
run Inesita::Server.new
