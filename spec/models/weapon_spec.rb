require 'rails_helper'

RSpec.describe Weapon, type: :model do
  context 'when there are no other weapon with the name' do
    let(:new_weapon) { build(:weapon) }

    it 'expects to be valid' do
      expect(new_weapon).to be_valid
    end

    it 'expects to save the new weapon' do
      expect(new_weapon.save).to be true
    end
  end

  context 'when there is a saved weapon with the name' do
    let(:name)       { Faker::Name.name }
    let(:new_weapon) { build(:weapon, name: name) }

    before do
      create(:weapon, name: name)
    end

    it 'expects to not be valid' do
      expect(new_weapon).not_to be_valid
    end

    it 'expects to not save the new weapon' do
      expect(new_weapon.save).to be false
    end
  end
end
