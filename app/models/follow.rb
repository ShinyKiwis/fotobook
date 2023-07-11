# == Schema Information
#
# Table name: follows
#
#  id          :bigint           not null, primary key
#  followee_id :integer
#  follower_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Follow < ApplicationRecord
  belongs_to :followee, class_name: 'User', foreign_key: 'followee_id'
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
end
