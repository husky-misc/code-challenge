require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject(:customer) { build(:customer) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  describe "#full_name" do
    it 'joins first name and last name' do
      expect(customer.full_name).to include(customer.first_name, customer.last_name)
    end
  end

  describe 'after creation' do
    it 'creates an account' do
      customer.save
      expect(customer.account).not_to be_nil
    end
  end
end
