class CreditCard::Transaction < ApplicationRecord
  include AASM

  scope :by_status, ->(status) { status ? where(status: status) : all }

  belongs_to :credit_card

  validates :amount, numericality: { greater_than: 0, only_integer: true }
  validates :currency, presence: true

  aasm column: :status, no_direct_assignment: true do
    state :started, initial: true
    state :paid, :dispute, :refunded, :failed

    event :pay do
      transitions from: %i[started dispute], to: :paid
    end

    event :start_dispute do
      transitions from: :paid, to: :dispute
    end

    event :refund do
      transitions from: :dispute, to: :refunded
    end

    event :invalidate do
      transitions from: :started, to: :failed
    end
  end

  paginates_per 5
end
