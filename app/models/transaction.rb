class Transaction < ApplicationRecord
  validates_presence_of :status, :amount, :currency
  belongs_to :credit_card

  enum status: %i[pending paid failed dispute refunded]
end
