require 'rails_helper'

RSpec.describe Matches::StartService do
  describe '.call' do
    let(:match_id)  { Faker::Number.number(digits: 10).to_s }
    let(:start)     { '23/04/2013 15:34:22'.to_time }
    let(:file_path) { Rails.root.join('spec', 'support', 'new_match_log') }
    let(:log_file)  { File.open(file_path) }

    context 'when match_id parameter is missing' do
      let(:service) { Matches::StartService.new(nil, start, log_file) }

      it 'expects to raise an ActiveModel::ValidationError' do
        expect { service.call }.to(
          raise_error(
            ActiveModel::ValidationError,
            "Validation failed: Match can't be blank"
          )
        )
      end
    end

    context 'when start param is missing' do
      let(:service) { Matches::StartService.new(match_id, nil, log_file) }

      it 'expects to raise an ActiveModel::ValidationError' do
        expect { service.call }.to(
          raise_error(
            ActiveModel::ValidationError,
            "Validation failed: Start can't be blank"
          )
        )
      end
    end

    context 'when log_file param is missing' do
      let(:service) { Matches::StartService.new(match_id, start, nil) }

      it 'expects to raise an ActiveModel::ValidationError' do
        expect { service.call }.to(
          raise_error(
            ActiveModel::ValidationError,
            "Validation failed: Log file can't be blank"
          )
        )
      end
    end

    context 'when the parameters are present' do
      let(:service) { Matches::StartService.new(match_id, start, log_file) }

      it 'expects to create a new valid match object' do
        expect(service.call).to be_valid
      end

      it 'expects to create a new match in database' do
        expect { service.call }.to change(Match, :count).by(1)
      end
    end

    context 'when match already exists in database' do
      let(:service) { Matches::StartService.new(match_id, start, log_file) }

      before do
        create(:finished_match, match_id: match_id)
      end

      it 'expects to raise an error' do
        expect { service.call }.to raise_error(
          ActiveRecord::RecordInvalid,
          'Validation failed: Match has already been taken'
        )
      end
    end
  end
end
