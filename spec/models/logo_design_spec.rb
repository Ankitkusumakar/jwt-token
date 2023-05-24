require 'rails_helper'

RSpec.describe LogoDesign, type: :model do
  describe 'association'  do
    it { should have_one_attached(:logo)}
  end 
end
