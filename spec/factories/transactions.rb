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
FactoryBot.define do
  factory :transaction do
    transient { credit_card { create(:credit_card) } }

    currency { Faker::Currency.code }
    amount { Faker::Number.within(range: 1..10000) }
    status { rand(0..3) }
    credit_card_id { credit_card.id }
  end
end
