class CreditCard < ApplicationRecord
  belongs_to :account
  has_one :customer, through: :account
  has_many :transactions, class_name: 'CreditCard::Transaction', inverse_of: :credit_card

  validates :spent_limit, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :number, numericality: { only_integer: true }, length: { maximum: 16 }
  validates :expiration_date, numericality: { only_integer: true }, length: { is: 4 }
  validates :cvv, numericality: { only_integer: true }, length: { minimum: 3, maximum: 4 }
  validates :customer_full_name, presence: true
end
