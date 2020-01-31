class AddLocationIdToHabits < ActiveRecord::Migration[6.0]
  def change
    add_column :habits, :location_id, :integer
  end
end
