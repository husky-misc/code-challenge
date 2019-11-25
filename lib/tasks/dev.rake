namespace :dev do
  desc "Set up the development environment"
  task setup: :environment do

    puts "Creating bank statements receipts..."

    50.times do |i|
      statement = BankStatement.create!(total: 0)
      Random.rand(5).times do |i|
        transaction = Transaction.create!(
          amount: Faker::Number.decimal(l_digits: 2),
          credit_card:Faker::Finance.credit_card(:mastercard, :visa),
          installments:Faker::Number.within(range: 1..10)
        )
        statement.total += transaction.amount
        statement.transactions << transaction
        statement.save!
      end
    end

    puts "Bank statements created with success!"

  end
end
