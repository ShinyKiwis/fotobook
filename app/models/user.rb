class User < ApplicationRecord
  has_many :following, class_name => 'Follow', foreign_key => 'followee_id'
  has_many :followees, through => :following

  has_many :followed, class_name => 'Follow', foreign_key => 'follower_id'
  has_many :followers, through => :followed

  has_many :albums
  has_many :photos

  validate :first_name, length: { maximum: 25 }, presence: true
  validate :last_name, length: { maximum: 25 }, presence: true
  validate :email, length: { maximum: 255 }, presence: true, 
    format: { with: /^[A-Za-z0-9+_.-]+@([A-Za-z0-9]+\.)+[A-Za-z]{2,6}$/, message: 'Email must be valid!' }
  validate :password, length: { maximum: 64 }
end
