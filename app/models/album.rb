# == Schema Information
#
# Table name: albums
#
#  id               :bigint           not null, primary key
#  title            :string
#  description      :string
#  thumbnail_img    :string
#  like_count       :integer          default(0)
#  sharing_mode     :string           default("public")
#  publication_date :datetime
#  user_id          :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Album < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :liked_albums

  validates :title, length: { maximum: 140 }, presence: true
  validates :description, length: { maximum: 300 }, presence: true
  validates :sharing_mode, presence: true
end
