require 'rails_helper'

RSpec.describe CreditCard::Transaction, type: :model do
  subject { build(:credit_card_transaction) }

  it { is_expected.to validate_numericality_of(:amount).is_greater_than(0).only_integer }
  it { is_expected.to validate_presence_of(:currency) }

  describe 'aasm' do
    context 'when :started' do
      it { is_expected.to allow_transition_to(:paid) }
      it { is_expected.to allow_transition_to(:failed) }
    end

    context 'when :paid' do
      subject { build(:credit_card_transaction, :paid) }

      it { is_expected.not_to allow_transition_to(:failed) }
      it { is_expected.to allow_transition_to(:dispute) }
    end

    context 'when :dispute' do
      subject { build(:credit_card_transaction, :dispute) }

      it { is_expected.to allow_transition_to(:paid) }
      it { is_expected.to allow_transition_to(:refunded) }
    end
  end
end
