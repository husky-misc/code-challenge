module AppServices
  module Ranking
    # Responsible to generate global ranking. ::AppServices::Ranking::ProccessGlobalRankingService

    class ProccessGlobalRankingService
      def initialize
        @response = { result: [], errors: [] }
        @match_ids = []
      end

      def call
        try_proccess_global_ranking

        @response
      end

      private

      def try_proccess_global_ranking
        ::Log.where(is_valid: true).map do |log|
          match_ids = ::Match.where(ranking_id: log.ranking.id).pluck(:id)

          @match_ids += match_ids
        end

        @response[:result] = ::AppServices::Ranking::PrepareRankingDataService.new(@match_ids).call
      rescue StandardError => _e
        @response[:errors].append('Error on generating the global ranking!')
      end
    end
  end
end
