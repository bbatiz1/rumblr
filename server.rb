require 'sinatra/activerecord'
require 'sinatra'
require 'sinatra/flash'
require './models'
require 'pg'

set :port, 3000
set :database, {url: ENV['DATABASE_URL']}
enable :sessions

get '/home' do
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
    redirect '/home'
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
  redirect '/home'
else
  flash[:error] = @user.errors.full_message
  redirect '/signup'
end
  p params
end

get '/profile' do
  erb :profile
end

get'/show' do
  @posts = Post.order(created_at: :desc).all
  erb :show
end

get '/blogs' do
  erb :blogs
end
post '/blogs' do
  @post = Post.new(title: params[:blog]['title'], content: params[:blog]['content'], user_id: session[user.id])
  if @post.valid?
    @post.save
    redirect '/show'
  else
    erb :profile
end

get '/logout' do
  session[:user_id] = nil
  redirect '/login'
  'You are logged out!'
end
end
#this is a piece of code i took
#def Logout
#  sessions[:user_id] = nil
#  flash[:notice] = 'Logged out'
#  redirect_to(access_login_path)
#end
