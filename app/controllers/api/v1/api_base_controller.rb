class Api::V1::ApiBaseController < ApplicationController
  WillPaginate.per_page = 5

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def not_found(exception)
    render json: { error: exception.message }, status: 404
  end
end
