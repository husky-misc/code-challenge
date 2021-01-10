module ValidateStatus
  extend ActiveSupport::Concern

  attr_reader :status

  included do
    before_action :set_status, only: :index
    before_action :validate_status, only: :index
  end

  private

  def set_status
    @status = transaction_params[:status]
  end

  def validate_status
    return if status.nil?

    not_found('Status not found') unless Transaction.statuses.include? status
  end
end
