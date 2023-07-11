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
require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
