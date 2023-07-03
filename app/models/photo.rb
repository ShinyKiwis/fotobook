class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :album
  has_one :photo

  validate :title, length: { maximum: 140 }, presence: true
  validate :description, length: { maximum: 300 }, presence: true
  validate :sharing_mode, presence: true
end
