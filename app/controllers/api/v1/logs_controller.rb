# Responsible to handle log entity. ::Api::V1::LogsController

module Api
  module V1
    class LogsController < ::Api::V1::ApiController
      def create
        resource(log_params)

        resource.save ? redirect_to_ranking : render_errors(resource.errors)
      end

      private

      def resource_class
        ::Log
      end

      def log_params
        params.permit(:game_mode, :description, :file)
      end

      def redirect_to_ranking
        redirect_to controller: '/api/v1/rankings', action: 'create', log_id: resource.id
      end
    end
  end
end
