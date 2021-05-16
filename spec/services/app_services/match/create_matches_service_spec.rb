require 'rails_helper'

RSpec.describe ::AppServices::Match::CreateMatchesService, type: :service do
  describe '.call' do
    context 'when a valid matches on file is provided' do
      subject(:response) { described_class.new(ranking.id, log_file).call }

      let(:log_file) { File.read("#{fixture_path}/files/matches/valid_match.txt") }
      let(:ranking) { create(:ranking) }

      it { expect(response[:errors]).to eq([]) }
    end

    context 'when an invalid matches on file is provided' do
      subject(:response) { described_class.new(ranking.id, log_file).call }

      let(:log_file) { File.read("#{fixture_path}/files/matches/invalid_match_content.txt") }
      let(:ranking) { create(:ranking) }

      it {
        expect(response[:errors]).to eq(['Something went wrong! Some match has an invalid format!',
                                         'Something went wrong creating matches!'])
      }
    end
  end
end
