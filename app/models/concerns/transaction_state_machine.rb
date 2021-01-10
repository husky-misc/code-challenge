module TransactionStateMachine
  extend ActiveSupport::Concern
  included do
    include AASM
    enum status: %i[started failed paid refunded dispute]

    aasm column: 'status', enum: true, whiny_transitions: false do
      state :started, initial: true
      state :failed
      state :paid
      state :refunded
      state :dispute

      event :pay do
        transitions from: :started, to: :paid, guard: :has_limit?, success: :withdraw
        transitions from: :started, to: :failed
      end

      event :dispute do
        transitions from: :paid, to: :dispute
        transitions from: :dispute, to: :paid
      end

      event :refund do
        transitions from: :dispute, to: :refunded, success: :restore_limit
      end
    end
  end

  private

  def withdraw
    credit_card.withdraw(amount)
  end

  def restore_limit
    credit_card.restore_limit(amount)
  end

  def has_limit?
    credit_card.spent_limit >= amount
  end
end
