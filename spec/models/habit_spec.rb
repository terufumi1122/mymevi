require 'rails_helper'

RSpec.describe Habit, type: :model do
  let!(:user)       { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:habit)      { create(:habit, user_id: user.id) }

  describe 'ファクトリのテスト' do
    it '有効なファクトリを持つこと' do
      expect(habit).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    it 'user_idが無いと無効であること' do
      habit = build(:habit, user_id: nil)
      expect(habit).to_not be_valid
    end

    it 'nameがないと無効であること' do
      habit = build(:habit, name: nil)
      expect(habit).to_not be_valid
    end

    it 'descriptionがないと無効であること' do
      habit = build(:habit, description: nil)
      expect(habit).to_not be_valid
    end

    it 'meritがないと無効であること' do
      habit = build(:habit, merit: nil)
      expect(habit).to_not be_valid
    end

    it 'bestがないと無効であること' do
      habit = build(:habit, best: nil)
      expect(habit).to_not be_valid
    end

    it 'name, description, user_idがあれば有効であること' do
      habit = create(:habit)
      expect(habit).to be_valid
    end
  end

  it 'location_idが1つある状態で有効であること' do
    habit = create(:habit, location_id: 1)
    expect(habit).to be_valid
  end

  it 'location_idが無くても有効であること' do
    habit = create(:habit, location_id: nil)
    expect(habit).to be_valid
  end
end
