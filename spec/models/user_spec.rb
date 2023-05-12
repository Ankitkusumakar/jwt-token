require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations user ' do
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
  end
	describe 'association ' do
    it { should have_one(:user_lang)}
  end 
end