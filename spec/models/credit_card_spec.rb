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
  pending "add some examples to (or delete) #{__FILE__}"
end
