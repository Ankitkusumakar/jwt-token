class User < ApplicationRecord
	before_create :generate_referral_code
    require "securerandom"
		has_secure_password
		validates :email, presence: true
		validates :password_digest, presence: true
		validates :username, presence: true,uniqueness: true

		has_one :user_lang
		has_many :logo_designs, foreign_key: 'account_id'
		has_many :messages
		
		has_many :referrals, foreign_key: :referrer_id, class_name: 'Referral'
    has_many :payments
    belongs_to :referrer, class_name: 'User', optional: true
    has_many :referred_users, through: :referrals, source: :referred

		 def generate_password_token!
			self.reset_password_token = generate_token
			self.reset_password_sent_at = Time.now.utc
			save!
		 end
		 
		 def password_token_valid?
			(self.reset_password_sent_at + 4.hours) > Time.now.utc
		 end
		 
		 def reset_password!(password)
			self.reset_password_token = nil
			self.password = password
			save!
		 end
		 
		def refer(referred_code)
			referred_user = User.find_by(referral_code: referred_code)
		
			if referred_user
				Referral.create(referrer: self, referred: referred_user)
				# You can perform additional actions here, such as rewarding the referrer or referred user
		
				# Example: Create a payment record for the referrer
					 # Adjust the amount as per your requirements
		
				# Example: Create a payment record for the referred user
				Payment.create(user: referred_user, amount: 5.0) # Adjust the amount as per your requirements
		
				return true
			else
				return false
			end
		end
		 
		 private
		 
		 def generate_token
			SecureRandom.hex(10)
		 end

		 def generate_referral_code
			self.referral_code = SecureRandom.hex(6)
		end
end
