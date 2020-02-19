class AddMeritToHabits < ActiveRecord::Migration[6.0]
  def up
    add_column :habits, :merit, :string, null: false
  end

  def down
    remove_column :habits, :merit, :string
  end
end
