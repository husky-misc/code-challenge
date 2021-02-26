require 'rails_helper'

RSpec.describe Player, type: :model do
  context 'when there are no other player with the nicknname' do
    let(:new_player) { build(:player) }

    it 'expects to be valid' do
      expect(new_player).to be_valid
    end

    it 'expects to save the new player' do
      expect(new_player.save).to be true
    end
  end

  context 'when there is a saved player with the nickname' do
    let(:nickname)   { Faker::Name.name }
    let(:new_player) { build(:player, nickname: nickname) }

    before do
      create(:player, nickname: nickname)
    end

    it 'expects to not be valid' do
      expect(new_player).not_to be_valid
    end

    it 'expects to not save the new player' do
      expect(new_player.save).to be false
    end
  end
end
