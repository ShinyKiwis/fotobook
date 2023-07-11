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
require "test_helper"

class LikedAlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
