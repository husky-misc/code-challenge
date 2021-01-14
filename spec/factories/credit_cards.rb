# == Schema Information
#
# Table name: credit_cards
#
#  id              :bigint           not null, primary key
#  cvv             :string           not null
#  expiration_date :date             not null
#  full_name       :string           not null
#  number          :string           not null
#  spent_limit     :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint           not null
#
# Indexes
#
#  index_credit_cards_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
FactoryBot.define do
  factory :credit_card do
    transient { account { create(:account) } }

    spent_limit { Faker::Number.within(range: 1000..50000) }
    number { Faker::Business.credit_card_number }
    expiration_date { Faker::Business.credit_card_expiry_date }
    cvv { Faker::Number.number(digits: 3).to_s }
    full_name { account.customer.full_name }
    account_id { account.id }
  end
end
