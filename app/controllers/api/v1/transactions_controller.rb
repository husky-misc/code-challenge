module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :set_credit_card
      before_action :set_transaction, only: %i[to_dispute refund]

      def index
        transactions = @credit_card.transactions
        transactions = transactions.where(status: params[:status]) if params[:status].present?

        transactions_json = TransactionSerializer.new(transactions).serialized_json

        render json: transactions_json, status: 200
      rescue StandardError => e
        render json: { error: e.message }, status: 500
      end

      def to_dispute
        if @transaction.dispute?
          render json: { message: 'This transaction is already in dispute' }, status: 200
        elsif @transaction.refunded?
          render json: { message: 'This transaction refunded' }, status: 200
        elsif @transaction.failed?
          render json: { message: 'This transaction failed' }, status: 200
        else
          @transaction.to_dispute
          if @transaction.save
            render json: @transaction, status: 200
          else
            render json: { error: 'We cannot change the transaction to dispute' }, status: 500
          end
        end
      rescue StandardError => e
        render json: { error: e.message }, status: 500
      end

      def refund
        if @transaction.dispute?
          @transaction.refund
          if @transaction.save
            render json: @transaction, status: 200
          else
            render json: { error: 'We cannot refund the transaction' }, status: 500
          end
        else
          render json: { message: 'The transaction must be in dispute to refund' }, stauts: 200
        end
      rescue StandardError => e
        render json: { error: e.message }, status: 200
      end

      private

      def set_credit_card
        customer = Customer.find(params[:customer_id])
        @credit_card = customer.credit_cards.find(params[:credit_card_id])
      end

      def set_transaction
        @transaction = @credit_card.transactions.find(params[:transaction_id])
      end
    end
  end
end
