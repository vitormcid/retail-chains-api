class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login  
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 5.minutes.to_i
      @user.update_attribute(:logout,false)
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def logout
    if @current_user.present?
      @current_user.update_attribute(:logout,true)
      render json: {message: "User successfully logged out"}, status: :ok
    else
      render json: { errors: 'User not found' }, status: :not_found
    end

  end

  private

  def login_params
    params.permit(:username, :password)
  end
end