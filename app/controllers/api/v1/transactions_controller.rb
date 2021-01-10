module Api::V1
  class TransactionsController < Api::V1::ApiBaseController
    include ValidateStatus

    def index
      @transactions =
        @credit_card
        .transactions.send(status || 'all').page(transaction_params[:page])
    end

    private

    def transaction_params
      params.permit(:page, :status)
    end
  end
end
