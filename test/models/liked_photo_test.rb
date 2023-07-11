# == Schema Information
#
# Table name: liked_photos
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  photo_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class LikedPhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
