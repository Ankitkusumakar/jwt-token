require 'rails_helper'

RSpec.describe UserLang, type: :model do
  describe 'association ' do
    it { should belong_to(:user)}
    it { should belong_to(:lang)}
  end 
end