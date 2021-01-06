# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.seed([
  { id: 1, first_name: 'Yukihiro', last_name: 'Matsumoto' },
  { id: 2, first_name: 'Sandi', last_name: 'Matz' },
  { id: 3, first_name: 'Martin', last_name: 'Fowler' },
  { id: 4, first_name: 'Dr. Alan', last_name: 'Kay' },
])

[
  [1, :visa],
  [2, :visa],
  [3, :mastercard],
  [4, :visa]
].each do |customer_id, card_type|
  customer = Customer.find(customer_id)

  CreditCard.seed do |s|
    s.id = customer_id
    s.customer = customer
    s.spent_limit = 10_000_00
    s.number = Faker::Finance.credit_card(card_type).delete('-')
    s.expiration_date = '0125'
    s.cvv = Faker::Number.number(digits: rand(3..4))
    s.customer_full_name = customer.full_name
  end
end

def create_transaction(customer_id, status)
  credit_card = Customer.find(customer_id).credit_cards.first
  transaction = credit_card.charge(amount: 100_00, currency: 'usd')
  transaction.update(status: status)
end

# 10 successful transactions

[
  [1, 5],
  [2, 3],
  [3, 1],
  [4, 1]
].each do |customer_id, transactions_count|
  transactions_count.times { create_transaction(customer_id, :paid) }
end

# 5 failed transactions

[
  [3, 3],
  [4, 2]
].each do |customer_id, transactions_count|
  transactions_count.times { create_transaction(customer_id, :failed) }
end

# 5 disputed transactions

[
  [1, 3],
  [2, 2]
].each do |customer_id, transactions_count|
  transactions_count.times { create_transaction(customer_id, :dispute) }
end
