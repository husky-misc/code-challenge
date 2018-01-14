require 'rails_helper'

describe Services::Compute, type: :services do
  context '.call' do
    let!(:ip) { create(:ip) }
    let!(:ip2) { create(:ip, values: [1,5]) }
    let(:result) { described_class.new.call }
    
    it { expect(result.length).to eq(1) }
    it { expect(result.first.values).to eq([1,2,3,5]) }
    it { expect(result.first.computed).to eq(true) }
  end
end