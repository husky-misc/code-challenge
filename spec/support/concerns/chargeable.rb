require 'spec_helper'

shared_examples_for 'chargeable' do
  let(:model) { create(described_class.to_s.underscore) }

  describe 'Relationships' do
    it 'is expected to have many transactions' do
      expect { model.to have_many(:transactions) }
    end
  end

  describe '.charge!' do
    subject { model.charge!(amount: amount, currency: 'whatever') }

    context 'when done' do
      let(:model) { create(described_class.to_s.underscore, spent_limit: 10_000_00) }
      let(:amount) { 100_00}

      it { is_expected.to be_truthy }
    end

    context 'when fail' do
      let(:model) { create(described_class.to_s.underscore, spent_limit: 100_00) }
      let(:amount) { 10_000_00 }

      it { is_expected.to be_falsey }
    end
  end
end
