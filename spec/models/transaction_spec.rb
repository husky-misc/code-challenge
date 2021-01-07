require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:currency) }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:credit_card) }
  end
  describe 'Data Mapping' do
    it { is_expected.to define_enum_for(:status).with_values(%i[pending paid failed dispute refunded]) }
  end
end
