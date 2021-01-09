require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:currency) }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:chargeable) }
  end

  describe 'Data Mapping' do
    it { is_expected.to define_enum_for(:status).with_values(%i[pending paid failed disputed refunded]) }
  end

  describe 'State Transitions' do
    it { is_expected.to transition_from(:pending).to(:paid).on_event(:pay) }
    it { is_expected.to transition_from(:disputed).to(:paid).on_event(:pay) }
    it { is_expected.to transition_from(:pending).to(:failed).on_event(:fail) }
    it { is_expected.to transition_from(:paid).to(:disputed).on_event(:dispute) }
    it { is_expected.to transition_from(:disputed).to(:refunded).on_event(:refund) }
  end


end
