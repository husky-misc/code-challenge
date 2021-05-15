class Player < ApplicationRecord
  self.table_name = :players

  belongs_to :match, class_name: '::Match', inverse_of: :players

  validates :match, :name, presence: true
  validates :name, uniqueness: { case_sensitive: true, scope: %i[match_id] }
end
