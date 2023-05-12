class ApplicationController < ActionController::Base
  # include JsonWebToken
  before_action :authenticate_request

	private
	def authenticate_request
		header = request.headers[:token] || params[:token]
		return render json: {error: "Token not found!"} unless header
		decode = JsonWebToken.jwt_decode(header)
		@current_user = User.find(decode[:id])
	end
end
