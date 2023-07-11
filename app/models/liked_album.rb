# == Schema Information
#
# Table name: liked_albums
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  album_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LikedAlbum < ApplicationRecord
  belongs_to :user
  belongs_to :album
end
