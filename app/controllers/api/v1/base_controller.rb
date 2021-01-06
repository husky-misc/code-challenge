class Api::V1::BaseController < ApplicationController
  private

  def render_error(msg, status = :unprocessable_entity)
    render json: { error: msg }, status: status
  end

  def render_json(resource, status = :ok)
    if resource.try(:errors)&.any?
      render_error(resource.errors.messages)
    else
      render json: resource, status: status
    end
  end

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_credit_card
    @credit_card = @customer.credit_cards.find(params[:credit_card_id] || params[:id])
  end
end
