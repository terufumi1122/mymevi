# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  habit_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_favorites_on_user_id_and_habit_id  (user_id,habit_id) UNIQUE
#

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let!(:user)        { create(:user) }
  let!(:other_user)  { create(:user) }
  let!(:habit)       { create(:habit, user_id: user.id) }
  let!(:other_habit) { create(:habit, user_id: user.id) }
  let!(:favorite)    { create(:favorite, user_id: user.id, habit_id: habit.id) }

  describe 'ファクトリのテスト' do
    it 'ファクトリが有効であること' do
      user
      expect(favorite).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    it 'user_idがないと無効であること' do
      favorite = build(:favorite, user_id: nil)
      expect(favorite.save).to be_falsey
    end

    it 'habit_idがないと無効であること' do
      favorite = build(:favorite, habit_id: nil)
      expect(favorite.save).to be_falsey
    end

    it 'user_idとhabit_idの組み合わせが重複すると保存出来ないこと' do
      other_favorite = build(:favorite, user_id: user.id, habit_id: habit.id)
      expect(other_favorite.save).to be_falsey
    end

    it 'user_idが同じでもhabit_idが異なっていれば有効であること' do
      other_favorite = build(:favorite, user_id: user.id, habit_id: other_habit.id)
      expect(other_favorite.save).to be_truthy
    end

    it 'habit_idが同じでもuser_idが異なっていれば有効であること' do
      other_favorite = build(:favorite, user_id: other_user.id, habit_id: habit.id)
      expect(other_favorite.save).to be_truthy
    end
  end
end
