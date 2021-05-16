require 'rails_helper'

RSpec.describe Player, type: :model do
  context 'when defining the model' do
    it { is_expected.to belong_to(:match) }

    it { is_expected.to validate_presence_of :match }
    it { is_expected.to validate_presence_of :name }
  end
end
