require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:currency) }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:chargeable) }
  end

  describe 'Data Mapping' do
    it { is_expected.to define_enum_for(:status).with_values(%i[pending paid failed disputed refunded]) }
  end

  describe 'State Transitions' do
    subject { build :transaction }
    it { is_expected.to have_state(:pending) }

    describe '.pay' do
      context 'with insufficient limit' do
        let(:chargeable) { build :credit_card, spent_limit: 1_000_00 }
        subject { build :transaction, chargeable: chargeable, amount: 10_000_00 }
        it { is_expected.to transition_from(:pending).to(:failed).on_event(:pay) }
      end

      context 'with enought limit' do
        let(:chargeable) { build :credit_card, spent_limit: 10_000_00 }
        subject { build :transaction, chargeable: chargeable, amount: 1_000_00 }
        it { is_expected.to transition_from(:pending).to(:paid).on_event(:pay) }
      end
      it { is_expected.to transition_from(:disputed).to(:paid).on_event(:pay) }
    end

    describe '.dispute' do
      it { is_expected.to transition_from(:paid).to(:disputed).on_event(:dispute) }
    end

    describe '.refund' do
      it { is_expected.to transition_from(:disputed).to(:refunded).on_event(:refund) }
    end

  end


end
