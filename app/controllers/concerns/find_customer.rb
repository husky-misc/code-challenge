module FindCustomer
  extend ActiveSupport::Concern

  included do
    before_action :set_customer
  end

  private

  def set_customer
    @customer = Customer.find(customer_id[:customer_id])
  end

  def customer_id
    params.permit(:customer_id)
  end
end
