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
class Account < ApplicationRecord
  belongs_to :customer

  has_many :credit_cards, dependent: :destroy

  accepts_nested_attributes_for :credit_cards
end
