class Customer < ApplicationRecord
  has_one :account

  validates :first_name, :last_name, presence: true
end
