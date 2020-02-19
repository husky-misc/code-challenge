# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

account = BankAccount.create

100000.times do
  account.transactions.create(description: "#{Faker::Games::Witcher.character} oren transfer",
                              transaction_type: rand(0..1),
                              amount: rand(0.0..2000.0).ceil(2),
                              created_at: Date.today - rand(0..30).day)
end