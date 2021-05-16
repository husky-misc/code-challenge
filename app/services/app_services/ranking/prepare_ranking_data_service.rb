module AppServices
  module Ranking
    # Responsible to prepare ranking data. ::AppServices::Ranking::PrepareRankingDataService

    class PrepareRankingDataService
      def initialize(match_ids)
        @match_ids = match_ids
        @current_players = []
        @current_match = {}
        @response = []
      end

      def call
        @match_ids.map do |match_id|
          @current_match = ::Match.find(match_id).attributes
          @current_players = ::Player.where(match_id: match_id).order(score: :desc)

          prepare_match_data

          @response.append(@current_match)
        end

        @response
      end

      private

      def prepare_match_data
        extract_winner
        extract_players
        extract_strike_player
      end

      def extract_winner
        @current_match[:winner] = @current_players.first
      end

      def extract_players
        @current_match[:players] = @current_players
      end

      def extract_strike_player
        @current_match[:strike_player] = @current_players.where(deads: 0).order(:frags).first
      end
    end
  end
end
