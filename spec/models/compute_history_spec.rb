require 'rails_helper'

describe ComputeHistory, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to embed_many(:ips) }
  it { is_expected.to validate_presence_of(:computed_at) }
end
