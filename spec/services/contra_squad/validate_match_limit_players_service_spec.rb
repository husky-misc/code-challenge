require 'rails_helper'

RSpec.describe ::ContraSquad::ValidateMatchLimitPlayersService, type: :service do
  describe '.call' do
    context 'when a valid player amount is provided' do
      subject(:response) do
        described_class.new(File.read("#{fixture_path}/files/matches/valid_match.txt")).call
      end

      it { expect(response[:result]).to eq(:valid) }
    end

    context 'when an invalid player amount is provided' do
      subject(:response) do
        described_class.new(File.read("#{fixture_path}/files/matches/invalid_match.txt")).call
      end

      it { expect(response[:errors]).to eq(['Some match exceeded the limit of players (2 - 20)']) }
    end

    context 'when an even player amount is provided in team modality' do
      subject(:response) do
        described_class
          .new(File.read("#{fixture_path}/files/matches/valid_team_match.txt"), :team).call
      end

      it { expect(response[:result]).to eq(:valid) }
    end

    context 'when an odd player amount is provided in team modality' do
      subject(:response) do
        described_class
          .new(File.read("#{fixture_path}/files/matches/invalid_team_match.txt"), :team).call
      end

      it { expect(response[:errors]).to eq(['Some match players amount is not even!']) }
    end
  end
end
