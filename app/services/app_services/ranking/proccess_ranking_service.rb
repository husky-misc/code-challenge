# Responsible to generate an ranking from file. ::AppServices::Ranking::ProccessRankingService

module AppServices
  module Ranking
    class ProccessRankingService
      def initialize
        @response = { result: '', errors: [] }
        @current_match_content = []
      end

      def call(log_file)
        try_proccess_ranking(log_file.strip)

        @response
      end

      private

      def try_proccess_ranking(log_file)
        @response = ::AppServices::Match::ExtractMatchesDataService.new(log_file).call

        prepare_ranking_data

        @response
      rescue StandardError => _e
        @response[:errors].append('Something went wrong! Check if the file log is really correct.')
      end

      def prepare_ranking_data
        @response[:result].map do |match|
          @current_match_content = match[:content]

          match[:content] = match[:content] +=
            ::AppServices::Ranking::PrepareRankingDataService.new(@current_match_content).call
        end

        @response
      end
    end
  end
end
