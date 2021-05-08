# Represents the logs table. ::Log

class Log < ApplicationRecord
  self.table_name = :logs

  GAME_MODES = %w[classic contra_squad].freeze

  has_one_attached :file
  has_one :ranking, class_name: '::Ranking', inverse_of: :log, dependent: :destroy

  validates :file, :game_mode, presence: true
  validates :file, attached: true, content_type: %i[txt]
  validates :game_mode, inclusion: { in: ::Log::GAME_MODES }
  validates :description, length: { minimum: 5, maximum: 100 }, allow_blank: true
end
