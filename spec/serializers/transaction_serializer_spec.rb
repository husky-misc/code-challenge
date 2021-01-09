require 'rails_helper'

describe TransactionSerializer do
  let(:transaction) { create(:transaction) }
  subject(:serializer) { described_class.new(transaction) }

  it 'serializes id' do
    expect(serializer.as_json[:id]).to eq(transaction.id)
    expect(serializer.as_json[:id]).to be_present
  end

  it 'serializes status' do
    expect(serializer.as_json[:status]).to eq(transaction.status)
    expect(serializer.as_json[:status]).to be_present
  end

  it 'serializes amount' do
    expect(serializer.as_json[:amount]).to eq(transaction.amount)
    expect(serializer.as_json[:amount]).to be_present
  end

  it 'serializes currency' do
    expect(serializer.as_json[:currency]).to eq(transaction.currency)
    expect(serializer.as_json[:currency]).to be_present
  end
  
  it 'serializes chargeable_id' do
    expect(serializer.as_json[:chargeable_id]).to eq(transaction.chargeable_id)
    expect(serializer.as_json[:chargeable_id]).to be_present
  end

  it 'serializes created_at' do
    expect(serializer.as_json[:created_at]).to eq(transaction.created_at.iso8601)
    expect(serializer.as_json[:created_at]).to be_present
  end
end
