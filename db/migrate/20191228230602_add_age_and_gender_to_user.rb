class AddAgeAndGenderToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :integer
  end
end
