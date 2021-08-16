class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  def show
    render json: @user
  end
  
  def create
    user = User.create(user_params)

    if user.valid?
      token = JWT.encode({ user_id: user.id }, ENV['JWT_SECRET'], 'HS256')
      render json: { user: user, token: token }
    else
      render json: user.errors.full_messages
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
