class AddNullTrueToHabitIdInLocatoins < ActiveRecord::Migration[6.0]
  def up
    change_column_null :locations, :habit_id, true
  end
  def down
    change_column_null :locations, :habit_id, false
  end
end
