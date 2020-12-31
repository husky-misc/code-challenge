customers = [
  {first_name: 'Yukihiro', last_name: 'Matsumoto'},
  {first_name: 'Sandi', last_name: 'Matz'},
  {first_name: 'Martin', last_name: 'Fowler'},
  {first_name: 'Dr. Alan', last_name: 'Kay'},
]

puts '########################################################################'
puts '>>> creating cutomers and accounts'

customers.each do |customer|
  customer = FactoryBot.create(
    :customer,
    first_name: customer[:first_name],
    last_name: customer[:last_name]
  )

  FactoryBot.create(:account, customer: customer)
end

puts '>>> customers and accounts created successfully!'

puts '########################################################################'
puts '>>> creating 20 transactions...'
puts '    | which 10 are successful transactions'

puts '    |    | 5 for Customer 1'
5.times do
  credit_card = FactoryBot.create(
    :credit_card,
    account: Account.find(1),
    spent_limit: rand(1_000_00..10_000_00)
  )
  transaction = FactoryBot.build(
    :transaction,
    credit_card: credit_card,
    amount: rand(100_00..1_000_00)
  )

  transaction.pay!
end

puts '    |    | 3 for Customer 2'
3.times do
  credit_card = FactoryBot.create(
    :credit_card,
    account: Account.find(2),
    spent_limit: rand(1_000_00..10_000_00)
  )
  transaction = FactoryBot.build(
    :transaction,
    credit_card: credit_card,
    amount: rand(100_00..1_000_00)
  )

  transaction.pay!
end

puts '    |    | 1 for Customer 3'
credit_card = FactoryBot.create(
    :credit_card,
    account: Account.find(3),
    spent_limit: rand(1_000_00..10_000_00)
  )
transaction = FactoryBot.build(
    :transaction,
    credit_card: credit_card,
    amount: rand(100_00..1_000_00)
  )
transaction.pay!

puts '    |    | 1 for Customer 4'
credit_card = FactoryBot.create(
    :credit_card,
    account: Account.find(4),
    spent_limit: rand(1_000_00..10_000_00)
  )
transaction = FactoryBot.build(
    :transaction,
    credit_card: credit_card,
    amount: rand(100_00..1_000_00)
  )
transaction.pay!
puts '    | 10 transactions created successfully!'
puts '    |'

puts '    | which 5 are failed transactions'
puts '    |    | 3 for Customer 3'
3.times do
  credit_card = FactoryBot.create(
    :credit_card,
    account: Account.find(3),
    spent_limit: rand(1_000_00..10_000_00)
  )
  transaction = FactoryBot.build(
    :transaction,
    credit_card: credit_card,
    amount: credit_card.spent_limit + 1_00
  )

  transaction.pay!
end
puts '    |    | 2 for Customer 4'
2.times do
  credit_card = FactoryBot.create(
    :credit_card,
    account: Account.find(4),
    spent_limit: rand(1_000_00..10_000_00)
  )
  transaction = FactoryBot.build(
    :transaction,
    credit_card: credit_card,
    amount: credit_card.spent_limit + 1_00
  )

  transaction.pay!
end
puts '    | 5 transactions created successfully!'
puts '    |'

puts '    | which 5 are disputed transactions'
puts '    |    | 3 for Customer 1'
3.times do
  credit_card = FactoryBot.create(
    :credit_card,
    account: Account.find(1),
    spent_limit: rand(1_000_00..10_000_00)
  )
  transaction = FactoryBot.build(
    :transaction,
    credit_card: credit_card,
    amount: rand(100_00..1_000_00)
  )

  transaction.pay!
  transaction.dispute!
end
puts '    |    | 2 for Customer 2'
2.times do
  credit_card = FactoryBot.create(
    :credit_card,
    account: Account.find(2),
    spent_limit: rand(1_000_00..10_000_00)
  )
  transaction = FactoryBot.build(
    :transaction,
    credit_card: credit_card,
    amount: rand(100_00..1_000_00)
  )

  transaction.pay!
  transaction.dispute!
end
puts '    | 5 transactions created successfully!'
puts '########################################################################'
puts '>>> seed finished successfully!'
