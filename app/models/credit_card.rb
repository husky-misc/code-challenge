class CreditCard < ApplicationRecord
  belongs_to :account
  has_one :customer, through: :account

  delegate :full_name, to: :customer, prefix: true

  validates :spent_limit, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :number, numericality: { only_integer: true }, length: { maximum: 16 }
  validates :expiration_date, numericality: { only_integer: true }, length: { is: 4 }
  validates :cvv, numericality: { only_integer: true }, length: { minimum: 3, maximum: 4 }
end
