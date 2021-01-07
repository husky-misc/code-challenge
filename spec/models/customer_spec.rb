require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe 'Relationships' do
    it { is_expected.to have_one(:account) }
  end

  describe '.full_name' do
    let(:customer) { build(:customer, first_name: 'Douglas', last_name: 'Adams') }
    subject { customer.full_name }

    it { is_expected.to eq('Douglas Adams') }

  end
end
