require 'rails_helper'

RSpec.describe Habit, type: :model do

  let(:habit) { create(:habit) }
  let(:user) { create(:user) }

  it "name, description, user_idがあれば有効であること" do
    # habit = Habit.new(
    #   name: "習慣1",
    #   description: "習慣の詳細です。",
    #   best: 1,
    #   user_id: 1 
    # )
    habit = FactoryBot.create(:habit)
    expect(habit
    ).to be_valid
  end
end