# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  birth_day              :integer          not null
#  birth_month            :integer          not null
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


class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :habits, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :locations, dependent: :destroy
  # validates_uniqueness_of :email, case_sensitive: true
  # validates :email, uniqueness: true, case_sensitive: true
  validates :email, uniqueness: true
  has_one_attached :eyecatch
  attr_accessor :avatar
end
