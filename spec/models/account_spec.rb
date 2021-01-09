require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'Relationships' do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to have_many(:credit_cards) }
  end
end
