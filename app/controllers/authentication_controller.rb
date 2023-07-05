class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
	skip_before_action :verify_authenticity_token

	def new
	end
	
  def create
		@user = User.find_by_email(params[:email])
		if @user&.authenticate(params[:password])
			token = JsonWebToken.jwt_encode(id: @user.id)
			session[:user_id] = @user.id
			redirect_to root_path, notice: "logged_in"
			# render json: { token: token }, status: :ok
		else
			render "new"
			render json: { error: 'unauthorized'}, status: :unauthorized
		end
	end
end
