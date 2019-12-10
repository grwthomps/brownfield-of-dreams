class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates_presence_of :first_name, :last_name

  validates :email, uniqueness: true, presence: true
  has_secure_password

  enum role: [:default, :admin]
end
