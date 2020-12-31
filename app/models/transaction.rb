class Transaction < ApplicationRecord
  include TransactionStateMachine

  belongs_to :credit_card

  validates_presence_of(
    :credit_card_id, :status, :amount, :currency
  )
  validates :amount, numericality: { greater_than: 0 }
end
