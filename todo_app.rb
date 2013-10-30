$LOAD_PATH.unshift(File.expand_path('.'))

require 'sinatra'
require 'sinatra/activerecord'
require 'new_relic/recipes'
require 'models/todo'
require 'new_relic'


# This loads environment variables from the .env file

ActiveRecord::Base.establish_connection(ENV['DATABASE)URL'] || "postgres://localhost/todos")

begin
  require 'dotenv'
  Dotenv.load
rescue LoadError
end


set :database, ENV['DATABASE_URL']

get '/' do
  @todos = Todo.all.reverse
  erb :index
end

post '/todos' do
  Todo.create(params)
  "Your task is: #{params[:task]}"
  redirect '/'
end

post '/completed/:id' do
  Todo.find(params[:id]).destroy
  redirect '/'
end