require 'rails_helper'

RSpec.describe ::Ranking, type: :model do
  context 'when defining the model' do
    it { is_expected.to belong_to(:log) }
    it { is_expected.to validate_presence_of :log }
  end

  context 'when saving the model' do
    subject(:ranking) { build(:ranking) }

    it { expect(ranking.save).to be_truthy }
  end
end
