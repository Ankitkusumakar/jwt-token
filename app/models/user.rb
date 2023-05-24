class User < ApplicationRecord
    require "securerandom"
		has_secure_password
		validates :email, presence: true
		validates :password_digest, presence: true
		validates :username, presence: true,uniqueness: true

		has_one :user_lang
		has_many :logo_designs, foreign_key: 'account_id'
end
