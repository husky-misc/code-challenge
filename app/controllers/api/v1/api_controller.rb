# Base controller api v1. ::Api::V1::ApiController

module Api
  module V1
    class ApiController < ApplicationController
      before_action :authorized

      def encode_token(payload)
        JWT.encode(payload, 'I_am_hired_by_husky!')
      end

      def auth_header
        request.headers['Authorization']
      end

      def decoded_token
        return unless auth_header

        token = auth_header.split(' ')[1]

        begin
          JWT.decode(token, 'I_am_hired_by_husky!', true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end

      def logged_in_user
        return unless decoded_token

        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
      end

      def logged_in?
        !!logged_in_user
      end

      def authorized
        return if logged_in?

        render json: { message: 'You are not authorized, please log in!' }, status: :unauthorized
      end

      private

      def resource_class
        ::ApplicationRecord
      end

      def resource(attrs = nil)
        @resource ||= resource_class.new(attrs)
      end

      def resource_from_id(id_symbol)
        self.resource = resource_class.find(params.require([id_symbol]))
      rescue StandardError => _e
        resource.errors.add(:base, :invalid_resource_from_id)
      end

      def errors
        @errors ||= []
      end

      def apply_errors(errors)
        @errors = errors
      end

      def render_errors(errors)
        apply_errors(errors)

        render_bad_request
      end

      def render_index(resources)
        render json: resources, status: :ok
      end

      def render_show(resource)
        render json: resource, status: :ok
      end

      def render_create(resource)
        render json: resource, status: :created
      end

      def render_bad_request
        render json: { errors: errors }, status: :bad_request
      end

      def render_unprocessable
        render json: { errors: resource.errors }, status: :unprocessable_entity
      end

      def render_error_message(message, status = :unprocessable_entity)
        render json: { errors: message }, status: status
      end
    end
  end
end
