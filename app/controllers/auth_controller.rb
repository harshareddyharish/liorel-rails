class AuthController < ApplicationController
  skip_before_action :valid_user, only: [:sign_in]

  def sign_in
    @user = User.find_by_email params[:email]
    if @user
      if @user.valid_password?(params[:password])
        token = SecureRandom.hex(25)
        UserToken.create(user_id: @user.id, token: token, signed_in_at: Time.now)
        render json: { message: 'Successfully signed in', user: @user, user_token: token }, status: 200
      else
        render json: { message: 'Password is wrong' }, status: 401
      end
    else
      render json: { message: 'Email is wrong' }, status: 401
    end
  end

  def sign_out
  	if @user
  		@user.user_tokens.update_all(token: nil)
  		render json: { message: 'Successfully signed out' }, status: 200
  	else
  		render json: { message: 'Failed to signed out' }, status: 422
  	end	
  end
end
