class Transaction < ApplicationRecord
  belongs_to :credit_card

  enum status: %i[paid failed refunded dispute]

  validates_presence_of(
    :credit_card_id, :status, :amount, :currency
  )
  validates :amount, numericality: { greater_than: 0 }
end
