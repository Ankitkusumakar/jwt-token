class ChatgptService
    include HTTParty

    attr_reader :api_url, :options, :model, :message
  
    def initialize(message, model = 'gpt-3.5-turbo')
      api_key = Rails.application.credentials.chatgpt_api_key
      @options = {
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer {Xs8ufsskFOAPT7f8uRcTT3BlbkFJFsVbct3PzmuOKDzdccVQ}"
        }
      }
      @api_url = 'https://chat.openai.com/'
      @model = model
      @message = message
    end
  
    def call
      body = {
        prompt: message,
        temperature: 0.7,
        max_tokens: 150,
        stop: ["\n", "User:"]
      } 
      response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 10)
      raise response['error'] unless response.code == 200
  
      response['choices'][0]['text']
    end
  
    class << self
      def call(message, model = 'gpt-3.5-turbo')
        new(message, model).call
      end
    end
  end