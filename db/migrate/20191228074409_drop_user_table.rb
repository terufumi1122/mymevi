class DropUserTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :users do |t|
      t.string "name"
      t.string "email"
      t.string "password_digest"
      t.integer "age"
      t.integer "gender"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: fals
    end
  end
end
