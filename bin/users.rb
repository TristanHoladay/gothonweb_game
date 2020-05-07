require 'rubygems'
require 'json'

module Users

  def store_user(username, password)
    @users = []
    @username = username
    @password = password
    new_user = [@username, @password]
    @users.push(new_user)
    $stdout = File.open('names.txt', 'a+')
    puts @users.to_json
  end
end


# class Users
#
#   def initialize(username, password)
#     @username = username
#     @password = password
#   end
#
#   def valid?
#     validate
#     @message.nil?
#     p @message
#   end
#
#   def message
#     @message
#   end
#
#   private
#
#   def validate
#
#     if @username.empty?
#       @message = "Please input a username."
#     elsif @password.empty?
#       @message = "Please input a password."
#     end
#
#
#
#
#     if @users.include?(@username)
#       i = @users.index(@username)
#
#       if i[1] == @password
#         @authorize = true
#         @message = "Welcome #{@username}"
#       else
#         @authorize = false
#         @message = "Wrong password. Please check your spelling and try again."
#       end
#
#     else
#       @message = "That username does not exist. Please make sure to check your spelling."
#     end
#
#   end
# end
