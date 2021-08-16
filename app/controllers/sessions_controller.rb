class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id }, ENV['JWT_SECRET'], 'HS256')
      render json: { user: user, token: token }
    else
      render json: ["Invalid username or password"]
    end
  end

  def auto_login
    if request.headers['Authorization']
      encoded_token = request.headers['Authorization'].split(" ")[1]
      token = JWT.decode(encoded_token, ENV['JWT_SECRET'])
      user_id = token[0]['user_id']
      user = User.find(user_id)
      render json: user
    end
  end
end