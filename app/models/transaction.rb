# == Schema Information
#
# Table name: transactions
#
#  id             :bigint           not null, primary key
#  amount         :float            not null
#  currency       :string           not null
#  status         :integer          not null
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
  belongs_to :credit_card

  delegate :spent_limit, to: :credit_card

  enum status: {
    dispute: 0,
    paid: 1,
    failed: 2,
    refunded: 3
  }

  scope :status, ->(status) { where(status: status) }

  validates_presence_of :amount, :currency, :status
end
