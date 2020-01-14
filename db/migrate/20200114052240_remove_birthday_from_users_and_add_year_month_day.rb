class RemoveBirthdayFromUsersAndAddYearMonthDay < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :birthday
    add_column :users, :birth_year, :integer
    add_column :users, :birth_month, :integer
    add_column :users, :birth_day, :integer
  end
end
