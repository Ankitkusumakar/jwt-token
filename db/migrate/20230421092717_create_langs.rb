class CreateLangs < ActiveRecord::Migration[6.0]
  def change
    create_table :langs do |t|
      t.string :name
      t.string :abbreviation
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
