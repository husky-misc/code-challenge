class Api::V1::ApiBaseController < ApplicationController
  include FindCustomer
  include FindCreditCard

  WillPaginate.per_page = 5

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def not_found(message)
    render json: { error: message }, status: :not_found
  end
end
