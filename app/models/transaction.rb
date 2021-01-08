class Transaction < ApplicationRecord
  include AASM

  validates_presence_of :status, :amount, :currency
  validates_numericality_of :amount

  belongs_to :credit_card

  enum status: %i[pending paid failed disputed refunded]
  aasm column: :status, enum: true do
    state :pending, initial: true
    state :paid
    state :failed
    state :disputed
    state :refunded

    event :pay do
      transitions from: :pending, to: :paid
      transitions from: :disputed, to: :paid
    end

    event :fail do
      transitions from: :pending, to: :failed
    end

    event :refund do
      transitions from: :disputed, to: :refunded
    end

    event :dispute do
      transitions from: :paid, to: :disputed
    end
  end
end
