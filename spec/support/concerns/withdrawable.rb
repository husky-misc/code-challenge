require 'spec_helper'

shared_examples_for 'withdrawable' do
  let(:model) { create(described_class.to_s.underscore) }

  describe '.withdraw!' do
    let(:model) { create(described_class.to_s.underscore, spent_limit: spent_limit) }
    subject { model.withdraw!(amount) }

    let(:spent_limit) { 100_000_00 }
    let(:amount) { 50_000_00 }

    it { is_expected.to be_truthy }
    it 'is expected to withdraw the amount from limit' do
      model.withdraw!(amount)
      expect(model.spent_limit).to eq(spent_limit - amount)
    end
  end
end
