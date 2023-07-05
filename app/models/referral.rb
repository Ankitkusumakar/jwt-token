class Referral < ApplicationRecord
  belongs_to :referrer, class_name: 'User'
  belongs_to :referred, class_name: 'User'

  validates :referrer, :referred, presence: true
  validates :referred_id, uniqueness: { scope: :referrer_id }
end
