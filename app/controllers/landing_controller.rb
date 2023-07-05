class LandingController < ApplicationController
  skip_before_action :authenticate_request
	skip_before_action :verify_authenticity_token
  def index
      @message = Message.new
  end
end
