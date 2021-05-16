# Responsible to handle ranking entity. ::Api::V1::RankingsController

module Api
  module V1
    class RankingsController < ::Api::V1::ApiController
      def create
        resource({ log: log })

        success, response, errors = resource.generate

        success ? render_create(response) : render_errors(errors)
      end

      def show
        resource_from_id(:ranking_id)

        resource.errors ? render_errors(resource.errors) : render_show(resource)
      end

      private

      def resource_class
        ::Ranking
      end

      def log
        @log ||= ::Log.find(params.require(:log_id))
      end
    end
  end
end
