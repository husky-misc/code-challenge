json.current_page @transactions.current_page
json.total_pages @transactions.total_pages

json.customer do
  json.id
  json.name @customer.full_name

  json.credit_card do
    json.id @credit_card.id
    json.spent_limit @credit_card.spent_limit
    json.number @credit_card.number
    json.expiration_date @credit_card.expiration_date
    json.cvv @credit_card.cvv

    json.transactions @transactions do |transaction|
      json.id transaction.id
      json.created transaction.created_at.to_i
      json.status transaction.status
      json.amount transaction.amount
      json.currency transaction.currency
      json.credit_card_id transaction.credit_card_id
    end

  end
end



