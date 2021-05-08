require 'rails_helper'

RSpec.describe ::AppServices::Log::ValidateLogFileService, type: :service do
  describe '.call' do
    context 'when a valid file block is provided' do
      subject(:response) { described_class.new(log_file, :contra_squad).call }

      let(:log_file) { File.read("#{fixture_path}/files/matches/valid_match.txt") }

      it { expect(response[:errors]).to eq([]) }
    end

    context 'when an invalid file block is provided' do
      subject(:response) { described_class.new(log_file, :contra_squad).call }

      let(:log_file) { File.read("#{fixture_path}/files/matches/invalid_match_block.txt") }

      it {
        expect(response[:errors]).to eq([
                                          'The match block provided is invalid!',
                                          'Some match players amount is not even!'
                                        ])
      }
    end
  end
end
