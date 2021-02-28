class Player < ApplicationRecord
  has_many :plays
  validates :nickname, presence: true, uniqueness: true
end
