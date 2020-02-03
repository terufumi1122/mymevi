class ChangeTypeDescriptionInHabit < ActiveRecord::Migration[6.0]
  def up
    change_column :habits, :description, :text, null: false
  end

  def down
    change_column :habits, :description, :string, null: false
  end
end
