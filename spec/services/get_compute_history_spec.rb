require 'rails_helper'

describe Services::GetComputeHistory, type: :services do
  context '.call' do
    let!(:compute_history)  { create(:compute_history) }
    let!(:compute_history2) { create(:compute_history) }
    
    it { expect(described_class.new(page: 1, per: 1).call.to_a.length).to eq(1) }
    it { expect(described_class.new(page: 2, per: 1).call.to_a.length).to eq(1) }
    it { expect(described_class.new(page: 3, per: 1).call.to_a.length).to eq(0) }
    it { expect(described_class.new(page: 1, per: 2).call.to_a.length).to eq(2) }
  end
end