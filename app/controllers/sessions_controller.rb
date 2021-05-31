class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:username], password: params[:password])
    if user
      render json: user
    else
      render json: ["Invalid username or password"]
    end
  end
end