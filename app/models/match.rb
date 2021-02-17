class Match < ApplicationRecord
  validates :match_id, :start_date, presence: true

  validates :match_id, uniqueness: true
end
