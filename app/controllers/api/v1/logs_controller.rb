# Responsible to handle log entity. ::Api::V1::LogsController

module Api
  module V1
    class LogsController < ::Api::V1::ApiController
      def create
        resource(create_log_params)

        resource.save ? render_create(resource) : render_errors(resource.errors)
      end

      def show
        id = params[:id]

        id == 'team' ? send_log('team_match') : send_log('match')
      end

      private

      def resource_class
        ::Log
      end

      def create_log_params
        params.permit(:description, :team_mode, :file, :game_mode)
      end

      def send_log(filetype)
        send_file(Rails.root.join("public/#{filetype}.txt"), type: 'plain/text')
      end
    end
  end
end
