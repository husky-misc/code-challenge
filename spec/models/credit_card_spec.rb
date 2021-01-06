require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  subject { build(:credit_card) }

  it { is_expected.to validate_numericality_of(:spent_limit).is_greater_than_or_equal_to(0).only_integer }
  it { is_expected.to validate_numericality_of(:number).only_integer }
  it { is_expected.to validate_length_of(:number).is_at_most(16) }
  it { is_expected.to validate_numericality_of(:expiration_date).only_integer }
  it { is_expected.to validate_length_of(:expiration_date).is_equal_to(4) }
  it { is_expected.to validate_numericality_of(:cvv).only_integer }
  it { is_expected.to validate_length_of(:cvv).is_at_least(3).is_at_most(4) }
  it { is_expected.to validate_presence_of(:customer_full_name) }

  describe '#available_limit' do
    let(:credit_card) { create(:credit_card, spent_limit: 1_000_00) }

    it 'subtracts the sum of disputed transactions from spent limit' do
      create_pair(:credit_card_transaction, :dispute, amount: 100_00, credit_card: credit_card)
      expect(credit_card.available_limit).to eq(800_00)
    end
  end
end
