# == Schema Information
#
# Table name: photos
#
#  id               :bigint           not null, primary key
#  title            :string
#  description      :string
#  thumbnail_img    :string
#  like_count       :integer          default(0)
#  sharing_mode     :string           default("public")
#  publication_date :datetime
#  user_id          :bigint           not null
#  album_id         :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Photo < ApplicationRecord
  mount_uploader :thumbnail_img, PhotoUploader

  belongs_to :user
  belongs_to :album, optional: true
  has_many :liked_photos

  validates :title, length: { maximum: 140 }, presence: true
  validates :description, length: { maximum: 300 }, presence: true
  validates :sharing_mode, presence: true
end
