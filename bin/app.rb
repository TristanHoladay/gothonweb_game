require 'sinatra'
require 'mysql2'
require './lib/gothonweb/map.rb'
require './bin/users.rb'
require './bin/storing_users.rb'
require 'logger'

set :port, 8080
set :static, true
set :public_folder, File.dirname(__FILE__) + '/static'
set :views, "views"
enable :sessions
set :session_secret, 'BADSECRET'
set :show_exceptions, :after_handler

include Users
include StoringNames

mysql = Mysql2::Client.new(
  :host => "localhost",
  :username => "root",
  :password => '',
  :port => 3306,
  :database => "gothon_db"
)

class MyLog
  def self.log
    if @logger.nil?
      @logger = Logger.new STDOUT
      @logger.level = Logger::DEBUG
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S '
    end
    @logger
  end
end

error 'notUniqueUsernameException' do
  "Sorry that username is taken. Please try something else."
end


get '/' do
  session[:room] = 'START'
  redirect to('/login')
end

get '/login' do
  @results = mysql.query("SELECT * FROM users")
  erb :login, :locals => {'results' => @results}
end

post '/login' do
  @name = params[:username]
  @password = params[:password]

  #code to verify account
  

  # StoringNames.store_users('names.txt', @name, @password)
  erb :player, :locals => {'username' => @name}
end

get '/signup' do
  erb :sign_up
end

post '/signup'  do
  # input new user into database
  @name = params[:username]
  @password = params[:password]
  
  insert = mysql.query("INSERT INTO users (username, password) VALUES ('#{@name}', '#{@password}')")
  if(req.error)
    raise NotUniqueUsernameException
  end 
  
  erb :player, :locals => {'username' => @name}
end

get '/player' do
  erb :player
end

get '/game' do
  room = Map::load_room(session)

  if room
    erb :show_room, :locals => {:room => room}
  else
    erb :you_died
  end
end

post '/game' do
    room = Map::load_room(session)
    action = params[:action]

    if action != nil && room.paths.include?(action) == false
      redirect to('/error')
    end

    if room
        next_room = room.go(action) || room.go("*")

        if next_room
            Map::save_room(session, next_room)
        end

        redirect to('/game')
    else
        erb :you_died
    end
end

get '/error' do
  erb :invalid_response
end


# post '/save_image' do
#
#   @filename = params[:file][:filename]
#   file = params[:file][:tempfile]
#
#   File.open("./public/#{@filename}", 'wb') do |f|
#     f.write(file.read)
#   end
#
#   erb :show_image
#end
