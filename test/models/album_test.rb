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
require "test_helper"

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
