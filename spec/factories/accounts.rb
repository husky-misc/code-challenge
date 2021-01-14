# == Schema Information
#
# Table name: accounts
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#
# Indexes
#
#  index_accounts_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#
FactoryBot.define do
  factory :account do
    transient { customer { create(:customer) } }

    customer_id { customer.id }
  end
end
