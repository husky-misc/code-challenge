# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customer_one = Customer.create(first_name: 'Yukihiro', last_name: 'Matsumoto')
customer_two = Customer.create(first_name: 'Sandi', last_name: 'Matz')
customer_three = Customer.create(first_name: 'Martin', last_name: 'Fowler')
customer_four = Customer.create(first_name: 'Dr. Alan', last_name: 'Kay')

account_one = Account.create(customer_id: customer_one.id)
account_two = Account.create(customer_id: customer_two.id)
account_three = Account.create(customer_id: customer_three.id)
account_four = Account.create(customer_id: customer_four.id)

credit_card_one = CreditCard.create(
  account_id: account_one.id,
  number: '4916793613502348',
  cvv: '443',
  spent_limit: 250000,
  expiration_date: '2022/12/07',
  flag: 'Visa',
  customer_full_name: account_one.customer.full_name
)

credit_card_two = CreditCard.create(
  account_id: account_two.id,
  number: '4929551440422139',
  cvv: '322',
  spent_limit: 350000,
  expiration_date: '07/07/2021',
  flag: 'Visa',
  customer_full_name: account_two.customer.full_name
)

credit_card_three = CreditCard.create(
  account_id: account_three.id,
  number: '5414651510520330',
  cvv: '125',
  spent_limit: 450000,
  expiration_date: '2021/08/07',
  flag: 'MasterCard',
  customer_full_name: account_three.customer.full_name
)

credit_card_four = CreditCard.create(
  account_id: account_four.id,
  number: '4916971365086203',
  cvv: '881',
  spent_limit: 550000,
  expiration_date: '2021/08/07',
  flag: 'Visa',
  customer_full_name: account_four.customer.full_name
)

# successful transactions

1.upto(5) do |i|
  t = Transaction.create(currency: 'usd', amount: 10000 * i, credit_card_id: credit_card_one.id)
  t.check_status
  t.save!
end

1.upto(3) do |i|
  t = Transaction.create(currency: 'usd', amount: 10000 * i, credit_card_id: credit_card_two.id)
  t.check_status
  t.save!
end

t = Transaction.create(currency: 'usd', amount: 50000, credit_card_id: credit_card_three.id)
t.check_status
t.save!

t = Transaction.create(currency: 'usd', amount: 100000, credit_card_id: credit_card_four.id)
t.check_status
t.save!

# failed transactions

1.upto(3) do |i|
  t = Transaction.create(currency: 'usd', amount: 350000 + 100000 * i, credit_card_id: credit_card_three.id)
  t.check_status
  t.save!
end

1.upto(2) do |i|
  t = Transaction.create(currency: 'usd', amount: 450000 + 100000 * i, credit_card_id: credit_card_four.id)
  t.check_status
  t.save!
end

# disputed transactions

1.upto(3) do
  t = Transaction.create(currency: 'usd', amount: 10000, credit_card_id: credit_card_one.id)
end

1.upto(2) do
  t = Transaction.create(currency: 'usd', amount: 10000, credit_card_id: credit_card_two.id)
end
