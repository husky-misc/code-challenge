class Match < ApplicationRecord
  has_many :rounds

  validates :started_at, :finished_at, :external_id, :frags_count,
    presence: true

  validates :external_id, uniqueness: true

  def inc_frags_count
    self.frags_count += 1

    save
  end
end
