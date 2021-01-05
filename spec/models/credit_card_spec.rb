require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  subject { build(:credit_card) }

  it { is_expected.to validate_numericality_of(:spent_limit).is_greater_than_or_equal_to(0).only_integer }
  it { is_expected.to validate_numericality_of(:number).only_integer }
  it { is_expected.to validate_length_of(:number).is_at_most(16) }
  it { is_expected.to validate_numericality_of(:expiration_date).only_integer }
  it { is_expected.to validate_length_of(:expiration_date).is_equal_to(4) }
  it { is_expected.to validate_numericality_of(:cvv).only_integer }
  it { is_expected.to validate_length_of(:cvv).is_at_least(3).is_at_most(4) }
end
