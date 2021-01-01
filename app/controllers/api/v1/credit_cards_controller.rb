class Api::V1::CreditCardsController < Api::V1::ApiBaseController
  def create
    @transaction = @credit_card.transactions.new(credit_card_params)

    if @transaction.valid?
      @transaction.pay!
      render status: :created
    else
      render json: { error: @transaction.errors }, status: :bad_request
    end
  end

  private

  def credit_card_params
    params.permit(:currency, :amount)
  end
end
