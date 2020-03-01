# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  with_options presence: true do
    validates :name
    validates :email
  end

  validates :email, uniqueness: { case_sensitive: true }

  has_many         :habits,    dependent: :destroy
  has_many         :favorites, dependent: :destroy
  has_many         :locations, dependent: :destroy
  has_many         :comments, dependent: :destroy
  has_one_attached :eyecatch
  attr_accessor    :avatar
end
