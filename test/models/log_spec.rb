require 'rails_helper'

RSpec.describe ::Log, type: :model do
  context 'when defining the model' do
    it { is_expected.to have_one(:ranking) }
    it { is_expected.to validate_presence_of :file }
    it { is_expected.to validate_presence_of :game_mode }
    it { is_expected.to validate_inclusion_of(:game_mode).in_array(::Log::GAME_MODES) }
    it { is_expected.to validate_length_of(:description).is_at_least(5).is_at_most(100).allow_nil }
  end

  context 'when saving the model' do
    subject(:log) { build(:log) }

    it { expect(log.save).to be_truthy }
  end
end
