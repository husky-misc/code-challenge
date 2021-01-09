module Api
  module V1
    module CreditCards
      class ChargesController < ApplicationController
        def create
          if charge_service.call
            head :created
          else
            render json: { error: 'Insufficient Limit' }, status: :not_acceptable
          end
        end

        private

        def charge_service
          @charge_service ||= ::CreditCards::Charge.new(
            credit_card: credit_card,
            amount: charge_params.require(:amount),
            currency: charge_params.require(:currency)
          )
        end

        def customer
          @customer ||= Customer.find(customer_params[:customer_id])
        end

        def credit_card
          @credit_card ||= customer.credit_cards.find(credit_card_params[:credit_card_id])
        end

        def customer_params
          params.permit(:customer_id)
        end

        def credit_card_params
          params.permit(:credit_card_id)
        end

        def charge_params
          params.permit(:currency, :amount)
        end
      end
    end
  end
end
