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
end
