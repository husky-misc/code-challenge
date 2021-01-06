class Api::V1::TransactionsController < Api::V1::BaseController
  before_action :check_status_param, only: :index
  before_action :set_customer, :set_credit_card

  def index
    transactions = @credit_card.transactions.by_status(params[:status]).page(params[:page])
    render_json(transactions)
  end

  private

  def check_status_param
    return unless params[:status]

    valid_statuses = CreditCard::Transaction.aasm.states.map(&:name)
    return render_error('Invalid status', :bad_request) unless valid_statuses.include?(params[:status].to_sym)
  end
end
