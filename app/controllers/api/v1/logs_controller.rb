# Responsible to handle log entity. ::Api::V1::LogsController

module Api
  module V1
    class LogsController < ::Api::V1::ApiController
      def create
        resource(log_params)

        resource.save ? render_create(resource) : render_errors(resource.errors)
      end

      private

      def resource_class
        ::Log
      end

      def log_params
        params.permit(:description, :team_mode, :file, :game_mode)
      end
    end
  end
end
