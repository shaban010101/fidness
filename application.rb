require 'sinatra/base'
require 'sequel'
require 'bcrypt'

class FidnessApp < Sinatra::Base
  post '/api/users/?' do
      password = BCrypt::Password.create(params[:password])
      user = DB[:users].insert(email: params[:email], 
                        username: params[:username], 
                        first_name: params[:first_name],
                        last_name: params[:last_name],
                        password: password)

          if user
            status 201
          else
            status 402
          end  
  end

  run! if app_file == $0
end
