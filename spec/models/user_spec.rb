# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  birth_year             :integer          not null
#  current_sign_in_at     :datetime
#  email                  :string(255)      not null
#  encrypted_password     :string(255)      default(""), not null
#  gender                 :integer          not null
#  image                  :string(255)
#  last_sign_in_at        :datetime
#  name                   :string(255)      not null
#  nickname               :string(255)
#  provider               :string(255)      default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  tokens                 :text(65535)
#  uid                    :string(255)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

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
