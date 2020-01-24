class AddNullFalseToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :name, :string, null: false
    change_column :users, :email, :string, null: false
    change_column :users, :gender, :integer, null: false
    change_column :users, :birth_year, :integer, null: false
    change_column :users, :birth_month, :integer, null: false
    change_column :users, :birth_day, :integer, null: false
  end
end
