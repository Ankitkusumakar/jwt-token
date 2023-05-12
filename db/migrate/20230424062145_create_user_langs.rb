class CreateUserLangs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_langs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lang, null: false, foreign_key: true
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
