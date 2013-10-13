$LOAD_PATH.unshift(File.expand_path('.'))

require 'sinatra'
require 'sinatra/activerecord'

require 'models/todo'


# This loads environment variables from the .env file
require 'dotenv'

ActiveRecord::Base.establish_connection(ENV['DATABASE)URL'] || "postgres://localhost/todos")

Dotenv.load

set :database, ENV['DATABASE_URL']

get '/' do
  @todos = Todo.all
  @heart = "<3"
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