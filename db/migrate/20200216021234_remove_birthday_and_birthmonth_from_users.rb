class RemoveBirthdayAndBirthmonthFromUsers < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :birth_month, :integer
    remove_column :users, :birth_day, :integer
  end

  def down
    add_column :users, :birth_month, :integer, null: false
    add_column :users, :birth_day, :integer, null: false
  end
end
