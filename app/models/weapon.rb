class Weapon < ApplicationRecord
  has_many :plays
  validates :name, presence: true, uniqueness: true
end
