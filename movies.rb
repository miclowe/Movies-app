require 'pry'
gem 'sinatra', '1.3.0'
require 'sinatra'
require 'sinatra/reloader'
require 'better_errors'
require 'open-uri'
require 'uri'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path("..", __FILE__)
end

get '/' do
  erb :home, :layout => false
end

get '/search_results' do
  if !params[:title].nil?
    @title = params[:title]
    file = open("http://www.omdbapi.com/?s=#{URI.escape(@title)}")
    @results = JSON.load(file.read)
  end
  erb :search_results
end

get '/movie_details/:imdbID' do
  @imdbID = params[:imdbID]
  file = open("http://www.omdbapi.com/?i=#{URI.escape(@imdbID)}")
  @results = JSON.load(file.read)
  erb :movie_details
end

