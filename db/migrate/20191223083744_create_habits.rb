class CreateHabits < ActiveRecord::Migration[6.0]
  def change
    create_table :habits do |t|
      t.string :name
      t.string :description
      t.integer :best
      t.integer :user_id

      t.timestamps
    end
  end
end
