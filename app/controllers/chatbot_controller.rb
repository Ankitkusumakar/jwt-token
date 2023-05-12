class ChatbotController < ApplicationController
	skip_before_action :verify_authenticity_token
  def chat
    return render json: {error: "please pass messgae"} unless params[:message].present?
    client = OpenAI::Client.new(access_token: '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')
    response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [{ role: "user", content: params[:message]}], # Required.
          temperature: 0.7
      })
    render json: { answer: response["choices"][0]["message"]["content"] }
  end 
end