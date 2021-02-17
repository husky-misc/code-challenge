class Player < ApplicationRecord
  validates :name, presence: true

  has_many :frags
  has_many :deaths
end
