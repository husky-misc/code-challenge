# frozen_string_literal: true

class Transaction < ApplicationRecord
  include AASM

  before_save :set_status

  belongs_to :credit_card

  aasm do
    state :dispute, initial: true
    state :paid, :failed, :refunded

    event :pay do
      transitions from: :dispute, to: :paid
    end

    event :refund do
      transitions from: %i[dispute paid], to: :refunded
    end

    event :fail do
      transitions from: :dispute, to: :failed
    end

    event :to_dispute do
      transitions from: :paid, to: :dispute
    end
  end

  private

  def set_status
    current_state
  end
end
