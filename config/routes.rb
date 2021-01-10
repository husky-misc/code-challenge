Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get(
        '/customers/:customer_id/credit_cards/:credit_card_id/transactions',
        to: 'transactions#index',
        as: :transactions
      )

      post(
        '/customers/:customer_id/credit_cards/:credit_card_id/charge',
        to: 'credit_cards#charge',
        as: :credit_cards
      )
    end
  end
end
