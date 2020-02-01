class AddNullFalseToHabits < ActiveRecord::Migration[6.0]
  def change
    change_column :habits, :name, :string, null: false
    change_column :habits, :description, :string, null: false
    change_column :habits, :best, :integer, null: false
    change_column :habits, :user_id, :integer, null: false
  end
end
