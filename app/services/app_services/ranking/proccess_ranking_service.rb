# Responsible to generate an ranking from file. ::AppServices::Ranking::ProccessRankingService

module AppServices
  module Ranking
    class ProccessRankingService
      def initialize
        @response = { result: '', errors: [] }
      end

      def call(ranking_id, log_file)
        try_proccess_ranking(ranking_id, log_file.strip)

        @response
      end

      private

      def try_proccess_ranking(ranking_id, log_file)
        matches = ::AppServices::Match::CreateMatchesService.new(ranking_id, log_file).call

        ::AppServices::Player::CreatePlayersService.new(matches[:result]).call

        prepare_ranking_data(matches[:result].pluck(:id))

        @response
      rescue StandardError => _e
        @response[:errors].append('Something went wrong! Check if the file log is really correct.')
      end

      def prepare_ranking_data(match_ids)
        @response[:result] = ::AppServices::Ranking::PrepareRankingDataService.new(match_ids).call
      end
    end
  end
end
