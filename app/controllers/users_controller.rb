class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create]
	before_action :set_user, only: [:show, :destroy]
	skip_before_action :verify_authenticity_token


	def index
		@users = User.all
		render json: @users, status: :ok
	end

	def show
		render json: @user, status: :ok
	end

	def create
		@user = User.new(user_params)
		otp = SecureRandom.random_number(100_000..999_999).to_s
		if @user.save
			@user.update(otp_code: otp)
			CrudNotificationMailer.create_notification(@user).deliver_now
			render json: @user, status: :created
		else
			render json: { errors: @user.errors.full_messages},
			status: :unprocessable_entity
		end
	end

	def update
		unless @user.update(user_params)
			render json: { errors: @user.errors.full_massages},
			status: :unprocessable_entity
		end
	end

	def destroy
		@user.destroy
	end

	def verify_otp
    return render json: {error: "Please enter the email and OTP."}, status: :unprocessable_entity unless params[:email].present? && params[:otp].present?
		@user = User.find_by(email: params[:email])
		return render json: {message: "Account has already activated"} if @user.present? && @user.activated?
		if @user.present?
			if params[:otp] == @user.otp_code
				@user.update(activated: true)
				render json: {massage: "user has been actived"}, status: :ok
			else
				render json: {message: "Please enter the correct OTP."}, status: :unprocessable_entity
			end
		else
			render json: {message: "Account is not registrered with this email."}, status: :unprocessable_entity
		end
  end

	private
	def user_params
		params.permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

end
