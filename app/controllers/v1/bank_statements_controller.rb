module V1
  class BankStatementsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bank_statement, only: [:show, :update, :destroy]

    # GET /bank_statements
    def index
      page_number = params[:page].try(:[], :number)
      per_page = params[:page].try(:[], :size)
      @bank_statements = BankStatement.all.page(page_number).per(per_page) 

      render json: @bank_statements
    end

    # GET /bank_statements/1
    def show
      render json: @bank_statement
    end

    # POST /bank_statements
    def create
      @bank_statement = BankStatement.new(bank_statement_params)

      if @bank_statement.save
        render json: @bank_statement, include: [:transactions], status: :created, location: @bank_statement
      else
        render json: @bank_statement.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /bank_statements/1
    def update
      if @bank_statement.update(bank_statement_params)
        render json: @bank_statement, include: [:transactions]
      else
        render json: @bank_statement.errors, status: :unprocessable_entity
      end
    end

    # DELETE /bank_statements/1
    def destroy
      @bank_statement.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_bank_statement
        @bank_statement = BankStatement.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def bank_statement_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end
