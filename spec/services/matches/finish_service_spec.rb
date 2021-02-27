require 'rails_helper'

RSpec.describe Matches::FinishService do
  describe '.call' do
    let(:match)  { create(:started_match) }
    let(:finish) { match.start + 5.minutes }

    context 'when some parameter is missing' do
      context 'when parameter match is missing' do
        let(:service) { Matches::FinishService.new(nil, finish) }

        it 'expects to raise an ActiveModel::ValidationError' do
          expect { service.call }.to(
            raise_error(
              ActiveModel::ValidationError,
              "Validation failed: Match can't be blank"
            )
          )
        end
      end

      context 'when parameter finish is missing' do
        let(:service) { Matches::FinishService.new(match, nil) }

        it 'expects to raise an ActiveModel::ValidationError' do
          expect { service.call }.to(
            raise_error(
              ActiveModel::ValidationError,
              "Validation failed: Finish can't be blank"
            )
          )
        end
      end
    end

    context 'when the parameters are present' do
      let(:service) { Matches::FinishService.new(match, finish) }

      it 'expects to finish a match' do
        expect { service.call }.to change(match, :finish).from(nil).to(finish)
      end
    end
  end
end
