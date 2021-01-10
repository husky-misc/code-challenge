json.id @transaction.id
json.created @transaction.created_at.to_i
json.status @transaction.status
json.amount @transaction.amount
json.currency @transaction.currency
json.credit_card_id @transaction.credit_card_id
