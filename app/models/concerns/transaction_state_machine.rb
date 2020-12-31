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
        transitions from: :started, to: :paid, guard: :has_limit?, success: :withdraw_credit_card_limit
        transitions from: :started, to: :failed
      end

      event :dispute do
        transitions from: :paid, to: :dispute
        transitions from: :dispute, to: :paid
      end

      event :refund do
        transitions from: :dispute, to: :refunded, success: :restore_credit_card_limit
      end
    end
  end

  private

  def has_limit?
    credit_card.spent_limit >= amount
  end

  def withdraw_credit_card_limit
    credit_card.update(spent_limit: credit_card.spent_limit - amount)
  end

  def restore_credit_card_limit
    credit_card.update(spent_limit: credit_card.spent_limit + amount)
  end
end
