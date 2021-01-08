module Api
  module V1
    class CreditCardsController < ApplicationController
      before_action :set_credit_card

      def charge
        transaction = Transaction.new(charge_params)
        if transaction.save
          transaction_json = TransactionSerializer.new(transaction).serialized_json

          render json: transaction_json, status: 200
        else
          render json: { error: transaction.errors.message }, status: 400
        end
      rescue StandardError => e
        render json: { error: e.message }, status: 500
      end

      private

      def set_credit_card
        @credit_card = CreditCard.find(params[:credit_card_id])
      end

      def charge_params
        params.require(:transaction).permit(:amount, :currency)
      end
    end
  end
end
