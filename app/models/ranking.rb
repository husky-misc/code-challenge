# Represents the rankings table. ::Ranking

class Ranking < ApplicationRecord
  self.table_name = :rankings

  belongs_to :log, class_name: '::Log', inverse_of: :ranking

  validates :log, presence: true
end
