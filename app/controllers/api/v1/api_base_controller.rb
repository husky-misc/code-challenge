class Api::V1::ApiBaseController < ApplicationController
  before_action :set_customer, :set_credit_card

  WillPaginate.per_page = 5

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def set_customer
    @customer = Customer.find(general_params[:customer_id])
  end

  def set_credit_card
    @credit_card =
      @customer.credit_cards.find(general_params[:credit_card_id])
  end

  def not_found(message)
    render json: { error: message }, status: 404
  end

  def general_params
    params.permit(:customer_id, :credit_card_id)
  end
end
