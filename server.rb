require 'sinatra/activerecord'
require 'sinatra'
require 'sinatra/flash'
require './models'
require 'pg'

set :port, 3000
set :database, {url: ENV['DATABASE_URL']}
enable :sessions

get '/' do
  erb :pghome
end

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

get '/post' do
  erb :post
end

post '/post' do
  @post = Post.new(title: params['topic'], body: params['content'], user_id: session[:user_id])
  if @post.valid?
    session[:post_title] = @post.post_title
    session[:post_content] = @post.post_content
    @post.save
    redirect "/home"
end
get '/feed' do
  erb :feed
end
get '/logout' do
  session.clear
  p "You've successfully logged out"
  redirect '/login'
end
end
#this is a piece of code i took
#def Logout
#  sessions[:user_id] = nil
#  flash[:notice] = 'Logged out'
#  redirect_to(access_login_path)
#end
