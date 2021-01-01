customers = [
  { first_name: 'Yukihiro', last_name: 'Matsumoto' },
  { first_name: 'Sandi', last_name: 'Matz' },
  { first_name: 'Martin', last_name: 'Fowler' },
  { first_name: 'Dr. Alan', last_name: 'Kay' }
]

puts '########################################################################'
puts '>>> creating cutomers and accounts'

customers.each do |customer|
  customer = FactoryBot.create(
    :customer,
    first_name: customer[:first_name],
    last_name: customer[:last_name]
  )

  account = FactoryBot.create(:account, customer: customer)

  FactoryBot.create(
    :credit_card,
    account: account,
    spent_limit: 10_000_00
  )
end

puts '>>> customers and accounts created successfully!'

puts '########################################################################'
puts '>>> creating 20 transactions...'
puts '    | which 10 are successful transactions'

puts '    |    | 5 for Customer 1'
5.times do
  FactoryBot.build(
    :transaction,
    credit_card: CreditCard.find(1),
    amount: 1_000_00
  ).pay!
end

puts '    |    | 3 for Customer 2'
3.times do
  FactoryBot.build(
    :transaction,
    credit_card: CreditCard.find(2),
    amount: 1_000_00
  ).pay!
end

puts '    |    | 1 for Customer 3'
FactoryBot.build(
  :transaction,
  credit_card: CreditCard.find(3),
  amount: 1_000_00
).pay!

puts '    |    | 1 for Customer 4'
FactoryBot.build(
  :transaction,
  credit_card: CreditCard.find(4),
  amount: 1_000_00
).pay!


puts '    | which 5 are failed transactions'
puts '    |    | 3 for Customer 3'
3.times do
  FactoryBot.build(
    :transaction,
    credit_card: CreditCard.find(3),
    amount: 10_000_00
  ).pay!
end

puts '    |    | 2 for Customer 4'
2.times do
  FactoryBot.build(
    :transaction,
    credit_card: CreditCard.find(4),
    amount: 10_000_00
  ).pay!
end

puts '    | which 5 are disputed transactions'
puts '    |    | 3 for Customer 1'
3.times do
  transaction = FactoryBot.build(
    :transaction,
    credit_card: CreditCard.find(1),
    amount: 1_000_00
  )

  transaction.pay!
  transaction.dispute!
end
puts '    |    | 2 for Customer 2'
2.times do
  transaction = FactoryBot.build(
    :transaction,
    credit_card: CreditCard.find(2),
    amount: 1_000_00
  )

  transaction.pay!
  transaction.dispute!
end

puts '########################################################################'
puts '>>> seed finished successfully!'
