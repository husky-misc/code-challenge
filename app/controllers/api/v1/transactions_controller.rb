module Api
  module V1
    class TransactionsController < ApplicationController
      def index
        relation = credit_card.transactions
        relation = relation.where(status: transaction_params[:status]) if transaction_params[:status]

        render json: relation, status: :ok
      end

      private

      def transaction_params
        params.permit(:status)
      end

      def credit_card_params
        params.permit(:credit_card_id)
      end

      def customer_params
        params.permit(:customer_id)
      end

      def customer
        @customer ||= Customer.find(customer_params[:customer_id])
      end

      def credit_card
        @credit_card ||= customer.credit_cards.find(credit_card_params[:credit_card_id])
      end
    end
  end
end
