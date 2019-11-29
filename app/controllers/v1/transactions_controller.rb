module V1
  class TransactionsController < ApplicationController
    include ErrorSerializer

    before_action :authenticate_user!, except: [:show, :index]
    before_action :set_bank_statement

    # GET /bank_statements/1/transactions
    def show
      if stale?(last_modified: @bank_statement.transactions[0].updated_at)
        render json: @bank_statement.transactions
      end
    end

    # DELETE /bank_statements/1/transactions
    def destroy
      transaction = Transaction.find(transaction_params[:id])
      transaction.destroy
    end

    # POST /bank_statement/1/transaction
    def create
      @bank_statement.transactions << Transaction.new(transaction_params)

      if @bank_statement.save
        render json: @bank_statement.transactions, status: :created, location: v1_bank_statement_transactions_url(@bank_statement)
      else
        render json: ErrorSerializer.serialize(@bank_statement.errors), status: :unprocessable_entity
      end
    end

    # PATCH/PUT /bank_statement/1/transaction
    def update
      transaction = Transaction.find(transaction_params[:id])

      if transaction.update(transaction_params)
        render json: @bank_statement.transactions
      else
        render json: ErrorSerializer.serialize(@bank_statement.errors), status: :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_bank_statement
        @bank_statement = BankStatement.find(params[:bank_statement_id])
      end

      # Only allow a trusted parameter "white list" through.
      def transaction_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end
