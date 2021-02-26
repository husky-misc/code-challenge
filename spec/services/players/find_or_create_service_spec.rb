require 'rails_helper'

RSpec.describe Players::FindOrCreateService do
  describe '.call' do
    let(:nickname) { Faker::Name.name }

    context 'when nickname parameter is missing' do
      let(:service) { Players::FindOrCreateService.new(nil) }

      it 'expects to raise an ActiveModel::ValidationError' do
        expect { service.call }.to(
          raise_error(
            ActiveModel::ValidationError,
            "Validation failed: Nickname can't be blank"
          )
        )
      end
    end

    context 'when the parameter nickname is present' do
      context 'when player already exists' do
        let(:nickname) { Faker::Name.name }
        let(:service)  { Players::FindOrCreateService.new(nickname) }

        it 'expects to load player' do
          player = create(:player, nickname: nickname)
          expect(service.call).to eq player
        end
      end

      context 'when playe does not exist' do
        let(:nickname) { Faker::Name.name }
        let(:service)  { Players::FindOrCreateService.new(nickname) }

        it 'expects to create a new player' do
          expect { service.call }.to change(Player, :count).by(1)
        end

        it 'expects to return the new player' do
          expect(service.call).to be_a_kind_of Player
        end

        it 'expects player to have the new saved nickname' do
          player = service.call
          expect(player.nickname).to eq nickname
        end
      end
    end
  end
end
