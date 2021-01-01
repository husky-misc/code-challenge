require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it 'has valid parameters' do
    credit_card = create :credit_card

    expect(credit_card).to be_valid
  end

  it 'is not valid with empty parameters' do
    credit_card = CreditCard.new

    expect(credit_card).not_to be_valid
  end

  it 'is not valid without an account' do
    credit_card = build(:credit_card, account: nil)

    expect(credit_card).not_to be_valid
  end

  it 'cant have negative spent limit' do
    credit_card = build(:credit_card, spent_limit: -100)

    expect(credit_card).not_to be_valid
  end
end
