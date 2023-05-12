class CreateLogoDesigns < ActiveRecord::Migration[6.0]
  def change
    create_table :logo_designs do |t|
      t.bigint :account_id
      t.bigint :filesize
      t.string :filename
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
