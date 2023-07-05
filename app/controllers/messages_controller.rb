class MessagesController < ApplicationController
  skip_before_action :authenticate_request
	skip_before_action :verify_authenticity_token
  def new
    @message = Message.new
  end
  def create
    @message = Message.create(msg_params.merge(user_id: session[:user_id]))
    if @message.save
      ActionCable.server.broadcast "room_channel",
                                      content: @message.content, sent_by: @message.user.username    
    else
      
    end
  end
  private
  def msg_params
    params.require(:message).permit(:content, :user_id)
  end
end
