class CreateReferrals < ActiveRecord::Migration[6.0]
  def change
    create_table :referrals do |t|
      t.integer :referrer_id
      t.integer :referred_id
      t.timestamps
    end
  end
end
