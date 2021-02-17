class Match < ApplicationRecord
  validates :match_id, :start_date, :end_date, :start_time, :end_time, presence: true
end
