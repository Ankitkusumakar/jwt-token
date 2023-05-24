require 'rails_helper'

RSpec.describe "LogodesignController", type: :controller do
    before(:each) do 
      @user = FactoryBot.create(:email)
      @logo = Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/image.jpg")
      @logo_design = FactoryBot.create(:logo_design, logo: @logo)
			@controller = LogodesignController.new
      token= JWT.encode({id: @user.id, exp: 2000.days.from_now.to_i}, Rails.application.secret_key_base)
      request.headers.merge!('token': "#{token}")
    end

    describe 'GET #index logo list' do
      it 'display all logo' do
        get 'index'
				data = JSON.parse(response.body)
        expect(data.count).to eq(2)
        expect(data[0]["filename"]).to eq("s.png")
        expect(response.status).to eq 200
      end

      it 'display with id' do
        get 'index' , params: { id: @logo_design.id} 
				data = JSON.parse(response.body)
        expect(data.count).to eq(2)
        expect(data[0]["filesize"]).to eq(123)
        expect(response.status).to eq 200
      end

      it '#index  it is nil id' do
        get 'index' , params: { id: nil} 
				data = JSON.parse(response.body)
        expect(data.count).to eq(2)
        expect(response.status).to eq 200
      end
    end

    describe "GET  show logo" do
      it 'display other logo' do 
        get 'show', params: { id: @logo_design.id}
				data = JSON.parse(response.body)
        expect(data.count).to eq(2)
        expect(data["filename"]).to eq(nil)
        expect(response).to have_http_status :ok 
      end
    end

    describe "#create,#create logo#post " do
      it 'logo create with params ' do
				post 'create', params: {logo: @logo}
				data = JSON.parse(response.body)
        expect(data.count).to eq(2)
        expect(data["logo"]["filename"]).to eq("image.jpg")
        expect(data["logo"]["account_id"]).to eq(@user.id)
        expect(response.status).to eq 200
      end
    end
    describe 'destroy' do 
      it 'logo delete with id' do 
        delete :destroy, params:{id: @logo_design.id}
				data = JSON.parse(response.body)
        expect(data.count).to eq(1)
        expect(response).to have_http_status :success
      end
    end 
    describe "#update,update logo#post " do
      it 'logo update with prarams logo' do 
        @logo = Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/image.jpg")
				put 'update', params: {id: @logo_design.id, data: {logo: @logo} } 
				data = JSON.parse(response.body)
        expect(response.status).to eq 200
      end
    end 
end
 