require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'ファクトリのテスト' do
    it '有効なファクトリを持つこと' do
      expect(create(:location)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    it 'Habitモデルとの関連付けがうまくいくこと'
    it '複数のHabitモデルと関連付けが出来ること'
  end
end
