require 'rails_helper'

RSpec.describe ::AppServices::Ranking::ProccessRankingService, type: :service do
  describe '.call' do
    context 'when a valid log file is provided' do
      subject(:response) { described_class.new.call(ranking.id, log_file) }

      let(:log_file) { File.read("#{fixture_path}/files/matches_log.txt") }
      let(:ranking) { create(:ranking) }

      it { expect(response[:errors]).to eq([]) }
    end

    context 'when an invalid log file is provided' do
      subject(:response) { described_class.new.call(ranking.id, log_file) }

      let(:log_file) { File.read("#{fixture_path}/files/matches/invalid_match_content.txt") }
      let(:ranking) { create(:ranking) }

      it {
        expect(response[:errors]).to eq(['Something went wrong! Check if the file log is really correct.'])
      }
    end
  end
end
