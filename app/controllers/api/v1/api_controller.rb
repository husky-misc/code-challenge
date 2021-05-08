# Base controller api v1. ::Api::V1::ApiController

module Api
  module V1
    class ApiController < ApplicationController
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
    end
  end
end
