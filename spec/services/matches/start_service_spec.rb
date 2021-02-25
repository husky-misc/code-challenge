require 'rails_helper'

RSpec.describe Matches::StartService do
  describe '.call' do
    let(:match_id)    { '12837' }
    let(:match_begin) { '23/04/2013 15:34:22'.to_time }

    context 'when some parameter is missing' do
      context 'when match_id is missing' do
        let(:service) { Matches::StartService.new(nil, match_begin) }

        it 'expects to raise an ActiveModel::ValidationError' do
          expect { service.call }.to(
            raise_error(
              ActiveModel::ValidationError,
              "Validation failed: Match can't be blank"
            )
          )
        end
      end

      context 'when match_begin is missing' do
        let(:service) { Matches::StartService.new(match_id, nil) }

        it 'expects to raise an ActiveModel::ValidationError' do
          expect { service.call }.to(
            raise_error(
              ActiveModel::ValidationError,
              "Validation failed: Match begin can't be blank"
            )
          )
        end
      end
    end

    context 'when the parameters are present' do
      let(:service) { Matches::StartService.new(match_id, match_begin) }
      let(:match)   { service.call }

      it 'expects to create a new valid match object' do
        expect(match).to be_valid
      end
    end
  end
end
