class CreateSpends < ActiveRecord::Migration[6.0]
  def change
    create_table :spends do |t|
      t.bigint :account_id
      t.string :name
      t.bigint :amount
      t.datetime :spend_date
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
