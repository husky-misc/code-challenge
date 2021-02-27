class Match < ApplicationRecord
  has_one_attached :file
  validates :match_id, :file, :start, presence: true
  validates :match_id, uniqueness: true
end
