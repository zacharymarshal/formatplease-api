require 'rubygems'
require 'sinatra'
require 'yaml'
require 'haml'
require 'prince-ruby'
require_relative 'paper'

CONFIG = YAML.load(File.read('config.yml'))
CONFIG = CONFIG.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo} # symbolize keys

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == [CONFIG[:username], CONFIG[:password]]
end

post '/' do
  paper_markdown = request.body.read
  paper = Paper.new paper_markdown

  headers 'Content-Type' => 'application/pdf'
  body paper.to_pdf
end