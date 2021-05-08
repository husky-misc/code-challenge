# Responsible to handle ranking entity. ::Api::V1::GlobalRankingsController

module Api
  module V1
    class GlobalRankingsController < ::Api::V1::ApiController
      def create
        response = ::AppServices::Ranking::ProccessGlobalRankingService.new.call

        handle_proccess_response(response)
      end

      private

      def resource_class
        ::Ranking
      end

      def handle_proccess_response(response)
        errors = response[:errors]

        errors.present? ? render_errors(errors) : render_create(response[:result])
      end
    end
  end
end
