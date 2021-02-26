class Player < ApplicationRecord
  validates :nickname, presence: true, uniqueness: true
end
