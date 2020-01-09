require 'sinatra/activerecord'
require 'sinatra'
require 'sinatra/flash'
require './models'

set :port, 3000
set :database, {url: ENV['DATABASE_URL']}
enable :sessions

get '/' do
  erb :home
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(email: params[:email])
  given_password = params[:password]
  if user.password == given_password
    session[:user_id] = user.id
    redirect '/profile'
  else
    flash[:error] = "Correct email, but wrong password."
    redirect "/login"
  end
end
get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(params[:user])
  if @user.valid?
  @user.save
  redirect '/profile'
else
  flash[:error] = @user.errors.full_message
  redirect '/signup'
end
  p params
end

get '/profile' do
  erb :profile
end

get '/logout' do
  erb :logout
end
get '/logout' do
  session.clear
  redirect '/login'
end
