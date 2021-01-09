require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it_behaves_like 'chargeable'
  it_behaves_like 'withdrawable'

  describe 'Validations' do
    it do
      is_expected.to validate_numericality_of(:spent_limit)
        .is_greater_than 0
    end

    it { is_expected.to validate_presence_of(:account_id) }
    it { is_expected.to validate_presence_of(:spent_limit) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:expiration_date) }
    it { is_expected.to validate_presence_of(:cvv) }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:account) }
  end

end
