# == Schema Information
#
# Table name: albums
#
#  id               :bigint           not null, primary key
#  title            :string
#  description      :string
#  like_count       :integer          default(0)
#  sharing_mode     :string           default("public")
#  publication_date :datetime
#  user_id          :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  photos           :json
#
class Album < ApplicationRecord
  paginates_per 40
  mount_uploaders :photos, PhotoUploader
  belongs_to :user
  has_many :photos

  has_many :liked_albums, dependent: :destroy
  has_many :likes, through: :liked_albums, source: :user

  validates :title, length: { maximum: 140 }, presence: true
  validates :description, length: { maximum: 300 }, presence: true
  validates :sharing_mode, presence: true
end
