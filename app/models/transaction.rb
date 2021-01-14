# == Schema Information
#
# Table name: transactions
#
#  id             :bigint           not null, primary key
#  amount         :float            not null
#  currency       :string           not null
#  status         :integer          default("dispute"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  credit_card_id :bigint           not null
#
# Indexes
#
#  index_transactions_on_credit_card_id  (credit_card_id)
#
# Foreign Keys
#
#  fk_rails_...  (credit_card_id => credit_cards.id)
#
class Transaction < ApplicationRecord
  include AASM

  belongs_to :credit_card

  delegate :spent_limit, to: :credit_card

  enum status: {
    dispute: 0,
    paid: 1,
    failed: 2,
    refunded: 3
  }, _prefix: :status # This prefix is needed because AASM overrides the enum methods

  aasm :column => 'status' do
    state :dispute, initial: true
    state :paid, :failed, :refunded
    
    event :pay do 
      transitions from: :dispute, to: :paid
    end
    
    event :dispute do 
      transitions from: :paid, to: :dispute
    end

    event :fail do
      transitions from: :dispute, to: :failed
    end
    
    event :refund do 
      transitions from: :dispute, to: :refunded, after: :refund_credit_card
    end
  end

  scope :credit_card, ->(credit_card) { where(credit_card: credit_card) }
  scope :status, ->(status) { where(status: status) }

  validates_presence_of :amount, :currency, :status

  def check_state
    charge_credit_card

    if amount <= spent_limit
      self.pay if may_pay?
    else amount > spent_limit
      self.fail if may_fail?
    end
  end

  private

  def charge_credit_card
    credit_card.update(spent_limit: spent_limit - amount) if spent_limit > amount
  end

  def refund_credit_card
    credit_card.update(spent_limit: spent_limit + amount)
  end
end
