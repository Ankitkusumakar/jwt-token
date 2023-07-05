class ChatbotController < ApplicationController
	skip_before_action :verify_authenticity_token
  def chat
    return render json: {error: "please pass messgae"} unless params[:message].present?
<<<<<<< HEAD
    client = OpenAI::Client.new(access_token: 'sk-xAyqOsS6LjDDiLw6fMYYT3BlbkFKuV5d2GagE')
=======
    client = OpenAI::Client.new(access_token: 'sk-SK')
>>>>>>> 7ed31d9c2f9d2709e68f826f6f74cca6b69ad289
    response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [{ role: "user", content: params[:message]}], # Required.
          temperature: 0.7
      })
    render json: { answer: response["choices"][0]["message"]["content"] }
  end 
end
