require 'rails_helper'

RSpec.describe ::AppServices::Log::ExtractModalityService, type: :service do
  describe '.call' do
    context 'when a combat file is provided' do
      subject(:response) { described_class.new(log_file).call }

      let(:log_file) { File.read("#{fixture_path}/files/matches/valid_match.txt") }

      it { expect(response).to eq(:combat) }
    end

    context 'when a team file is provided' do
      subject(:response) { described_class.new(log_file).call }

      let(:log_file) { File.read("#{fixture_path}/files/matches/valid_team_match.txt") }

      it { expect(response).to eq(:team) }
    end
  end
end
