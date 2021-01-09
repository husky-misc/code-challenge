# frozen_string_literal: true

class Transaction < ApplicationRecord
  include AASM

  belongs_to :credit_card

  validates_presence_of :amount, :currency

  aasm column: 'status' do
    state :dispute, initial: true
    state :paid, :failed, :refunded

    event :pay, after: :decrease_limit do
      transitions from: :dispute, to: :paid
    end

    event :refund do
      transitions from: %i[dispute], to: :refunded
    end

    event :fail do
      transitions from: :dispute, to: :failed
    end

    event :to_dispute, after: :back_limit do
      transitions from: :paid, to: :dispute
    end
  end

  def check_status
    if amount <= credit_card.spent_limit && !credit_card.expired?
      pay
    elsif amount > credit_card.spent_limit || credit_card.expired?
      self.fail
    end
  end

  private

  def decrease_limit
    credit_card.decrease_limit(amount)
  end

  def back_limit
    credit_card.back_limit(amount)
  end
end
