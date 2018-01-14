require 'rails_helper'

describe Ip, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:values) }
end
