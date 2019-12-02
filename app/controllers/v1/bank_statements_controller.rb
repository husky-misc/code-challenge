module V1
  class BankStatementsController < ApplicationController
    include ErrorSerializer

    before_action :set_bank_statement, only: [:show, :update, :destroy]

    # GET /bank_statements
    def index
      page_number = params[:page].try(:[], :number)
      per_page = params[:page].try(:[], :size)

      Rails.cache.fetch("bank_statements") do
        @bank_statements = Rack::Reducer.call(params, dataset: BankStatement.all.page(page_number).per(per_page), filters: [
          ->(numDays:) { where("created_at < ?", (numDays.to_i).days.ago) }
        ])  
      end

      if @bank_statements.empty?
        render json: @bank_statements
      else
        if stale?(last_modified: @bank_statements[0].updated_at)
          render json: @bank_statements
        end
      end
    end

    # GET /bank_statements/1
    def show
      render json: @bank_statement
    end

    # POST /bank_statements
    def create
      @bank_statement = BankStatement.new(bank_statement_params)

      if @bank_statement.save
        render json: @bank_statement, include: [:transactions], status: :created, location: v1_bank_statements_url(@bank_statement)
      else
        render json: ErrorSerializer.serialize(@bank_statement.errors), status: :unprocessable_entity
      end
    end

    # PATCH/PUT /bank_statements/1
    def update
      if @bank_statement.update(bank_statement_params)
        render json: @bank_statement, include: [:transactions]
      else
        render json: ErrorSerializer.serialize(@bank_statement.errors), status: :unprocessable_entity
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
