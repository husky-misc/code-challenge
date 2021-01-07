class Transaction < ApplicationRecord
  include AASM

  validates_presence_of :status, :amount, :currency
  belongs_to :credit_card

  enum status: %i[pending paid failed dispute refunded]
  aasm column: :status, enum: true do
    state :pending, initial: true
    state :paid
    state :failed
    state :dispute
    state :refunded

    event :pay do
      transitions from: :pending, to: :paid
      transitions from: :dispute, to: :paid
    end

    event :fail do
      transitions from: :pending, to: :failed
    end

    event :refund do
      transitions from: :dispute, to: :refunded
    end

    event :dispute do
      transitions from: :paid, to: :dispute
    end
  end
end
