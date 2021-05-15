# Responsible to handle user entity. ::Api::V1::UsersController

module Api
  module V1
    class UsersController < ::Api::V1::ApiController
      before_action :authorized, only: [:auto_login]

      def create
        resource(create_user_params).save
        token = encode_token({ user_id: resource.id })
        render_create({ user: resource, token: token })
      rescue StandardError => _e
        render_error_message('Something went wrong!')
      end

      def auto_login
        render json: @resource
      end

      private

      def resource_class
        ::User
      end

      def create_user_params
        params.permit(:email, :password)
      end
    end
  end
end
