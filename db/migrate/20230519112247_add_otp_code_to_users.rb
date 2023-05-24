class AddOtpCodeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :otp_code, :string
    add_index :users, :otp_code
  end
end
