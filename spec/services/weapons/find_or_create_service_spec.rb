require 'rails_helper'

RSpec.describe Weapons::FindOrCreateService do
  describe '.call' do
    let(:name) { Faker::Name.name }

    context 'when name parameter is missing' do
      let(:service) { Weapons::FindOrCreateService.new(nil) }

      it 'expects to raise an ActiveModel::ValidationError' do
        expect { service.call }.to(
          raise_error(
            ActiveModel::ValidationError,
            "Validation failed: Name can't be blank"
          )
        )
      end
    end

    context 'when the parameter name is present' do
      context 'when weapon already exists' do
        let(:name)     { Faker::Name.name }
        let(:service)  { Weapons::FindOrCreateService.new(name) }

        it 'expects to load weapon' do
          weapon = create(:weapon, name: name)
          expect(service.call).to eq weapon
        end
      end

      context 'when weapon does not exist' do
        let(:name)     { Faker::Name.name }
        let(:service)  { Weapons::FindOrCreateService.new(name) }

        it 'expects to create a new weapon' do
          expect { service.call }.to change(Weapon, :count).by(1)
        end

        it 'expects to return the new weapon' do
          expect(service.call).to be_a_kind_of Weapon
        end

        it 'expects weapon to have the new saved name' do
          weapon = service.call
          expect(weapon.name).to eq name
        end
      end
    end
  end
end
