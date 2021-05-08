module AppServices
  module Ranking
    # Responsible to generate global ranking. ::AppServices::Ranking::ProccessGlobalRankingService

    class ProccessGlobalRankingService
      def initialize
        @response = { result: [], errors: [] }
      end

      def call
        try_proccess_global_ranking

        @response
      end

      private

      def try_proccess_global_ranking
        ::Log.where(is_valid: true).map do |log|
          log_file = log.file.open { |file| File.read(file) }

          log_ranking = ::AppServices::Ranking::ProccessRankingService.new.call(log_file)

          raise StandardError if log_ranking[:errors].present?

          @response[:result].append(log_ranking[:result])
        end
      rescue StandardError => _e
        @response[:errors].append('Error on generating the global ranking!')
      end
    end
  end
end
