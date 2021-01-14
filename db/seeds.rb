# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.create(full_name: 'Yukihiro Matsumoto', account_attributes: 
  {
    credit_cards_attributes:
    [
      {
        spent_limit: 30000,
        number: '4024007197519852',
        expiration_date: 4.years.from_now,
        cvv: '149',
        full_name: 'Yukihiro Matsumoto',
        flag: 'visa'
      }
    ] 
  }
)

Customer.create(full_name: 'Sandi Matz', account_attributes: 
  { 
    credit_cards_attributes: 
    [
      {
        spent_limit: 30000, 
        number: '4929397797555240', 
        expiration_date: 4.years.from_now, 
        cvv: '673', 
        full_name: 'Sandi Matz', 
        flag: 'visa'
      }
    ]
  }
)

Customer.create(full_name: 'Martin Fowler', account_attributes: 
  { 
    credit_cards_attributes: 
    [
      {
        spent_limit: 30000, 
        number: '5566766353028625', 
        expiration_date: 4.years.from_now, 
        cvv: '851', 
        full_name: 'Martin Fowler', 
        flag: 'mastercard' 
      }
    ]
  } 
)

Customer.create(full_name: 'Dr. Alan Kay', account_attributes: 
  { 
    credit_cards_attributes: 
    [
      {
        spent_limit: 30000, 
        number: '4539961196797141', 
        expiration_date: 4.years.from_now, 
        cvv: '398', 
        full_name: 'Dr. Alan Kay', 
        flag: 'visa' 
      } 
    ]
  }
)

5.times do |i|
  transaction = Transaction.create(credit_card_id: 1, amount: 100, currency: 'USD')
  transaction.check_state
  transaction.save
end

3.times do |i|
  transaction = Transaction.create(credit_card_id: 2, amount: 100, currency: 'USD')
  transaction.check_state
  transaction.save
end

transaction = Transaction.create(credit_card_id: 3, amount: 100, currency: 'USD')
transaction.check_state
transaction.save

transaction = Transaction.create(credit_card_id: 4, amount: 100, currency: 'USD')
transaction.check_state
transaction.save

3.times do |i|
  transaction = Transaction.create(credit_card_id: 3, amount: 30001, currency: 'USD')
  transaction.check_state
  transaction.save
end

2.times do |i|
  transaction = Transaction.create(credit_card_id: 4, amount: 30002, currency: 'USD')
  transaction.check_state
  transaction.save
end

3.times do |i|
  transaction = Transaction.create(credit_card_id: 1, amount: 500, currency: 'USD')
end

2.times do |i|
  transaction = Transaction.create(credit_card_id: 2, amount: 500, currency: 'USD')
end
