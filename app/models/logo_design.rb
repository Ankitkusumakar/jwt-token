class LogoDesign < ApplicationRecord
  has_one_attached :logo
  belongs_to :user, foreign_key: 'account_id'
end
