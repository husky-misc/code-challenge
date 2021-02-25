require 'rails_helper'

RSpec.describe Matches::EndService do
  describe '.call' do
    let(:match)       { build(:started_match) }
    let(:match_end)   { Faker::Time.between(from: match.match_begin, to: match.match_begin + 1) }
    let(:file_path)   { Rails.root.join('spec', 'support', 'new_match_log') }
    let(:log_file)    { File.open(file_path) }

    context 'when some parameter is missing' do
      context 'when parameter match is missing' do
        let(:service) { Matches::EndService.new(nil, log_file, match_end) }

        it 'expects to raise an ActiveModel::ValidationError' do
          expect { service.call }.to(
            raise_error(
              ActiveModel::ValidationError,
              "Validation failed: Match can't be blank"
            )
          )
        end
      end

      context 'when parameter file is missing' do
        let(:service) { Matches::EndService.new(match, nil, match_end) }

        it 'expects to raise an ActiveModel::ValidationError' do
          expect { service.call }.to(
            raise_error(
              ActiveModel::ValidationError,
              "Validation failed: Log file can't be blank"
            )
          )
        end
      end

      context 'when parameter match_end is missing' do
        let(:service) { Matches::EndService.new(match, log_file, nil) }

        it 'expects to raise an ActiveModel::ValidationError' do
          expect { service.call }.to(
            raise_error(
              ActiveModel::ValidationError,
              "Validation failed: Match end can't be blank"
            )
          )
        end
      end
    end

    context 'when the parameters are present' do
      let(:service) { Matches::EndService.new(match, log_file, match_end) }

      it 'expects to create a new valid match object' do
        expect { service.call }.to change(Match, :count).by(1)
      end
    end
  end
end
