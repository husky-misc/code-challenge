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
require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  [:spent_limit, :number, :expiration_date, :cvv, :full_name].each { |attribute| it { should validate_presence_of(attribute) } }

  it { should validate_length_of(:full_name).is_at_least(2).is_at_most(26) }
end
