require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe 'ファクトリのテスト' do
    it '有効なファクトリを持つこと' do
      expect(user).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    it '名前、メール、パスワードがあれば有効な状態であること' do
      user = build(:user,
                   name: 'sample_user',
                   email: 'sample@sample.com',
                   password: 'password',
                   password_confirmation: 'password')
      expect(user.save).to be_truthy
    end

    it '名前がなければ無効な状態であること' do
      user = build(:user, name: nil)
      expect(user.save).to be_falsey
    end

    it 'メールアドレスがなければ無効な状態であること' do
      user = build(:user, email: nil)
      expect(user.save).to be_falsey
    end

    it 'パスワードがなければ無効な状態であること' do
      user = build(:user, password: nil)
      expect(user.save).to be_falsey
    end

    it '重複したメールアドレスなら無効な状態であること' do
      create(:user, email: 'sample@sample.com')
      user = build(:user, email: 'sample@sample.com')
      expect(user.save).to be_falsey
    end
  end
end
