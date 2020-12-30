require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'is valid with a customer' do
    account = build :account

    expect(account).to be_valid
  end

  it 'is not valid without a customer' do
    account = build(:account, customer: nil)

    expect(account).not_to be_valid
  end

  it 'is not valid with a customer that already has an account' do
    account = create :account

    invalid_account = build(:account, customer: account.customer)

    expect(invalid_account).not_to be_valid
  end
end
