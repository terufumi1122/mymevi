# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  lat        :float(53)        not null
#  lng        :float(53)        not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  habit_id   :integer
#  user_id    :integer          not null
#
# Indexes
#
#  index_locations_on_lat_and_lng  (lat,lng) UNIQUE
#

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
