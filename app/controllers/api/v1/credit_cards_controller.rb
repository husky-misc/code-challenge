class Api::V1::CreditCardsController < Api::V1::ApiBaseController
  def charge
    @transaction = @credit_card.charge!(credit_card_params)

    return render json: { error: @transaction.errors }, status: :bad_request if @transaction.errors.any?

    render status: :created
  end

  private

  def credit_card_params
    params.permit(:currency, :amount)
  end
end
