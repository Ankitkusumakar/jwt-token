class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
	skip_before_action :verify_authenticity_token
 
  def login
		@user = User.find_by_email(params[:email])
		if @user&.authenticate(params[:password])
			token = JsonWebToken.jwt_encode(id: @user.id)
			render json: { token: token }, status: :ok
		else
			render json: { error: 'unauthorized'}, status: :unauthorized
		end
	end
end
