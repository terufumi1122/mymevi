class AddLikesToHabits < ActiveRecord::Migration[6.0]
  def change
    add_column :habits, :likes, :integer
  end
end
