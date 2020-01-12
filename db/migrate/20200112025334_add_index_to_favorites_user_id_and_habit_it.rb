class AddIndexToFavoritesUserIdAndHabitIt < ActiveRecord::Migration[6.0]
  def change
    add_index :favorites, [:user_id, :habit_id], unique: true
  end
end
