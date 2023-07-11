# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string
#  avatar_img             :string
#  is_admin               :boolean          default(FALSE)
#  is_active              :boolean          default(TRUE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
class User < ApplicationRecord
  mount_uploader :avatar_img, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :following, class_name: 'Follow', foreign_key: 'followee_id'
  has_many :followees, through: :following

  has_many :followed, class_name: 'Follow', foreign_key: 'follower_id'
  has_many :followers, through: :followed

  has_many :albums
  has_many :photos

  validates :first_name, length: { maximum: 25 }, presence: true
  validates :last_name, length: { maximum: 25 }, presence: true
  validates :email, length: { maximum: 255 }, presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, length: { maximum: 64 }
end
