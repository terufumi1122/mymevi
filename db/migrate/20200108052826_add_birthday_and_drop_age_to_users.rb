class AddBirthdayAndDropAgeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birthday, :datetime
    remove_column :users, :age, :integer
  end
end
