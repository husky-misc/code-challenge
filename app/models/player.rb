class Player < ApplicationRecord
  validates :nickname, presence: true
  validates :nickname, uniqueness: true
end
