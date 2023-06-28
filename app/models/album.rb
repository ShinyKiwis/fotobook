class Album < ApplicationRecord
  belongs_to :user
  has_many :photos

  validate :title, length: { maximum: 140 }, presence: true
  validate :description, length: { maximum: 300 }, presence: true
  validate :sharing_mode, presence: true
end
