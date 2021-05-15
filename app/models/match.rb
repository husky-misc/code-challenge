class Match < ApplicationRecord
  self.table_name = :matches

  belongs_to :ranking, class_name: '::Ranking', inverse_of: :matches

  has_many :players, class_name: '::Player', inverse_of: :match, dependent: :destroy

  validates :ranking, :started_at, :ended_at, :content, presence: true

  validate :started_at_greater_than_ended_at, if: -> { dates_are_present? }

  private

  def dates_are_present?
    started_at.present? && ended_at.present?
  end

  def started_at_greater_than_ended_at
    errors.add(:started_at, :started_at_greater_than_ended_at) if started_at > ended_at
  end
end
