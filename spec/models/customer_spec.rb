require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject(:customer) { build(:customer) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  describe 'after creation' do
    it 'creates an account' do
      customer.save
      expect(customer.account).not_to be_nil
    end
  end
end
