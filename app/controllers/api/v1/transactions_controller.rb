module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :set_credit_card

      def index
        transactions = @credit_card.transactions
        transactions = transactions.where(status: params[:status]) if params[:status].present?

        transactions_json = TransactionSerializer.new(transactions).serialized_json

        render json: transactions_json, status: 200
      rescue StandardError => e
        render json: { error: e.message }, status: 500
      end

      private

      def set_credit_card
        customer = Customer.find(params[:customer_id])
        @credit_card = customer.credit_cards.find(params[:credit_card_id])
      end
    end
  end
end
