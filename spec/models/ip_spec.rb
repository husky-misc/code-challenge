require 'rails_helper'

describe Ip, type: :model do
  it { is_expected.to be_mongoid_document }
end
