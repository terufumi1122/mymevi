class AddNullFalseToFavorites < ActiveRecord::Migration[6.0]
  def change
    change_column :favorites, :user_id, :integer, null: false
    change_column :favorites, :habit_id, :integer, null: false
  end
end
