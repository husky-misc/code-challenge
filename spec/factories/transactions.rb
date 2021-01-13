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
FactoryBot.define do
  factory :transaction do
    credit_card { nil }
    currency { "MyString" }
    amount { 1.5 }
    status { 1 }
  end
end
