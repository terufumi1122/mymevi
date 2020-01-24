class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.float :lat, limit: 53, null: false
      t.float :lng, limit: 53, null: false
      t.integer :user_id, null: false
      t.integer :habit_id, null: false

      t.timestamps
    end
  end
end
