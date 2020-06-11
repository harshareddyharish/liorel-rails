class ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token
	before_action :valid_user

	def valid_user
		token = request.headers['USER-TOKEN']
		hanlde_unauthorize unless token
		user_token = UserToken.find_by(token: token)
		hanlde_unauthorize unless user_token
		@user = user_token.user
		true
	end

	def hanlde_unauthorize
		render json: 'Not Authorized', status: :unauthorized
	end
end
