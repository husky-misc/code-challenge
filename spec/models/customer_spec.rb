require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'is valid with valid attributes' do
    customer = build :customer

    expect(customer).to be_valid
  end

  it 'is not valid without attributes' do
    customer = build(:customer, first_name: '', last_name: '')

    expect(customer).to_not be_valid
  end

  it 'is not valid without a fist name' do
    customer = build(:customer, first_name: '')

    expect(customer).to_not be_valid
  end

  it 'is not valid without a last name' do
    customer = build(:customer, last_name: '')

    expect(customer).to_not be_valid
  end

  it '.full_name' do
    customer = create :customer

    expect(customer.full_name).to eq "#{customer.first_name} #{customer.last_name}"
  end
end
