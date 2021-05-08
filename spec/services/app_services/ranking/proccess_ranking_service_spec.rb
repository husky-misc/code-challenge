require 'rails_helper'

RSpec.describe ::AppServices::Ranking::ProccessRankingService, type: :service do
  describe '.call' do
    context 'when a valid log file is provided' do
      subject(:response) { described_class.new.call(log_file) }

      let(:log_file) { File.read("#{fixture_path}/files/matches_log.txt") }

      it { expect(response[:errors]).to eq([]) }
    end

    context 'when an invalid log file is provided' do
      subject(:response) { described_class.new.call(log_file) }

      let(:log_file) { File.read("#{fixture_path}/files/matches/invalid_match_content.txt") }

      it {
        expect(response[:errors]).to eq(['Something went wrong! Some match has an invalid format!'])
      }
    end
  end
end
