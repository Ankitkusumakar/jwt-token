require 'rails_helper'

RSpec.describe "Currencies", type: :request do
  describe "GET /convertor" do
    it "returns http success" do
      get "/currency/convertor"
      expect(response).to have_http_status(:success)
    end
  end

end
