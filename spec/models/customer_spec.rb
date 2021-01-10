require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'is invalid without first name' do
    customer = build(:customer, first_name: nil)
    customer.save

    expect(customer.errors.full_messages.first).to eq("First name can\'t be blank")
  end

  it 'is invalid without last name' do
    customer = build(:customer, last_name: nil)
    customer.save

    expect(customer.errors.full_messages.first).to eq("Last name can\'t be blank")
  end
end
