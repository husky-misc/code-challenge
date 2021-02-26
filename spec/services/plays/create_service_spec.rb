require 'rails_helper'

RSpec.describe Plays::CreateService do
  describe '.call' do
    let(:killer)   { create(:player) }
    let(:victim)   { create(:player) }
    let(:weapon)   { create(:weapon) }
    let(:match)    { create(:ended_match) }
    let(:gametime) { match.match_begin + 1.minute }

    context 'when parameter match is missing' do
      let(:service) do
        Plays::CreateService.new(
          match: nil,
          killer: killer,
          victim: victim,
          weapon: weapon,
          gametime: gametime
        )
      end

      it 'expects to raise an ActiveModel::ValidationError' do
        expect { service.call }.to(
          raise_error(
            ActiveModel::ValidationError,
            "Validation failed: Match can't be blank"
          )
        )
      end
    end

    context 'when parameter killer is missing' do
      let(:service) do
        Plays::CreateService.new(
          match: match,
          killer: nil,
          victim: victim,
          weapon: weapon,
          gametime: gametime
        )
      end

      it 'expects to raise an ActiveModel::ValidationError' do
        expect { service.call }.to(
          raise_error(
            ActiveModel::ValidationError,
            "Validation failed: Killer can't be blank"
          )
        )
      end
    end

    context 'when parameter victim is missing' do
      let(:service) do
        Plays::CreateService.new(
          match: match,
          killer: killer,
          victim: nil,
          weapon: weapon,
          gametime: gametime
        )
      end

      it 'expects to raise an ActiveModel::ValidationError' do
        expect { service.call }.to(
          raise_error(
            ActiveModel::ValidationError,
            "Validation failed: Victim can't be blank"
          )
        )
      end
    end

    context 'when parameter weapon is missing' do
      let(:service) do
        Plays::CreateService.new(
          match: match,
          killer: killer,
          victim: victim,
          weapon: nil,
          gametime: gametime
        )
      end

      it 'expects to raise an ActiveModel::ValidationError' do
        expect { service.call }.to(
          raise_error(
            ActiveModel::ValidationError,
            "Validation failed: Weapon can't be blank"
          )
        )
      end
    end

    context 'when parameter gametime is missing' do
      let(:service) do
        Plays::CreateService.new(
          match: match,
          killer: killer,
          victim: victim,
          weapon: weapon,
          gametime: nil
        )
      end

      it 'expects to raise an ActiveModel::ValidationError' do
        expect { service.call }.to(
          raise_error(
            ActiveModel::ValidationError,
            "Validation failed: Gametime can't be blank"
          )
        )
      end
    end

    context 'when parameter are present' do
      let(:service) do
        Plays::CreateService.new(
          match: match,
          killer: killer,
          victim: victim,
          weapon: weapon,
          gametime: gametime
        )
      end

      it 'expects to create a new play' do
        expect { service.call }.to change(Play, :count).by(1)
      end

      it 'expects to return a play' do
        expect(service.call).to be_a_kind_of Play
      end
    end
  end
end
