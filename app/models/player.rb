class Player < ApplicationRecord
  validate :nickname, presence: true
  validate :nickname, uniqueness: true
end
