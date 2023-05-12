require 'rails_helper'

RSpec.describe "SpendController", type: :controller do
  before(:each) do
    @user = FactoryBot.create(:email)
    @controller = SpendController.new
    @spend = FactoryBot.create(:spend)
    token= JWT.encode({id: @user.id, exp: 2000.days.from_now.to_i}, Rails.application.secret_key_base)
    request.headers.merge!('token': "#{token}")
  end
  
  describe "GET index" do
    it "returns a success response" do
      get :index, params: {year: "2023"}
      data = JSON.parse(response.body)
      expect(data["spends"].count).to eq(1)
      expect(data["spends"][0]["name"]).to eq("MyString")
      expect(response).to be_successful
    end
  end
  describe "GET #recent_spends" do
    it "returns a success response" do
      get :recent_spends
      data = JSON.parse(response.body)
      expect(data.count).to eq(1)
      expect(data[0]["amount"]).to eq(2000)
      expect(response).to be_successful
    end
  end
  describe "GET #show" do
      it "returns the spend" do
        get :show, params: { id: @spend.id }
        data = JSON.parse(response.body)
        expect(data.count).to eq(8)
        expect(data["account_id"]).to eq(15)
        expect(response).to have_http_status(:ok)
      end
  end
  describe 'destroy' do 
    it 'spennd delete with id' do 
      delete :destroy, params:{id: @spend.id}
      data = JSON.parse(response.body)
      expect(data.count).to eq(1)
      expect(response).to have_http_status :success
    end
  end
  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the spend' do
        patch :update, params: { id: @spend.id, account_id: 12, name: "aslld", amount:200, spend_date:2022-2-2 }
        data = JSON.parse(response.body)
        expect(data.count).to eq(8)
        expect(data["name"]).to eq("aslld")
        expect(response).to have_http_status(:ok)
      end
    end
  end
  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { account_id: 1, name: "Groceries", amount: 50, spend_date: Date.today, is_active: true } }
      it "creates a new spend" do
        post :create, params: valid_params
        data = JSON.parse(response.body)
        expect(data.count).to eq(8)
        expect(data["is_active"]).to eq(true)
        expect(response).to have_http_status(201)
      end
    end

    context "with invalid params" do
      it "returns errors" do
        post :create, params: {}
        data = JSON.parse(response.body)
        byebug
        expect(data.count).to eq(8)
        expect(data["name"]).to eq(nil)
        expect(data["account_id"]).to eq(nil)
        expect(data["amount"]).to eq(nil)
        expect(data["spend_date"]).to eq(nil)
        expect(JSON.parse(response.body)).to include{ { account_id: "", name: "", amount: "", spend_date: "", is_active: "" } }
      end
    end
  end
end