class PasswordsController < ApplicationController
  skip_before_action :authenticate_request
	skip_before_action :verify_authenticity_token
  def forgot
    if params[:email].blank? # check if email is present
      return render json: {error: 'Email not present'}
    end
    @user = User.find_by(email: params[:email]) # if present find user by email

    if @user.present?
      @user.generate_password_token! #generate pass token
      # SEND EMAIL HERE
			CrudNotificationMailer.create_notification(@user).deliver_now
      render json: {status: 'plss check your email and click reset password'}, status: :ok
    else
      render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
    end
  end

  def new
  end

  def reset
    token = params[:token].to_s

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        redirect_to auth_login_path, notice: "logged_in"
      end
    end
  end
end
