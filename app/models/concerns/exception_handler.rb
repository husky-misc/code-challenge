module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ error: e.message }, :not_found)
    end

    rescue_from ActionController::ParameterMissing do |e|
      json_response({ error: e.message }, :bad_request)
    end

    def json_response(object, status = :ok)
      render json: object, status: status
    end
  end
end
