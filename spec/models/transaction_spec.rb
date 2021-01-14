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
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  [:amount, :currency, :status].each { |attribute| it { should validate_presence_of(attribute) } }

  it { should delegate_method(:spent_limit).to(:credit_card)}

  it { should define_enum_for(:status).with_values(dispute: 0, paid: 1, failed: 2, refunded: 3)}
end
