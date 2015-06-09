require 'sinatra'
require 'sinatra/reloader'
require 'pg'

configure :development, :test do
  require 'pry'
end

Dir[File.join(File.dirname(__FILE__), 'lib', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

get '/' do
  erb :index
end

post '/' do
  if params[:recipe_name].empty?
    erb :error
  else
    erb :results, locals: {
      is_delicious: is_delicious?(params[:recipe_name]),
      recipe_name: params[:recipe_name]
    }
  end
end

def is_delicious?(recipe_name)
  recipe_name.downcase.include?("brussels sprouts")
end
