namespace :dev do
  desc "Set up the development environment"
  task setup: :environment do
    puts "Creating transactions..."
    
    100.times do |i|
      # create! is to showing the error on terminal
      Transaction.create!(
        amount: Faker::Number.decimal(l_digits: 2),
        currency:Faker::Currency.symbol,
        credit_card:Faker::Finance.credit_card(:mastercard, :visa),
        installments:Faker::Number.within(range: 1..10)
      )
    end
    
    puts "Transactions created with success!"
  end
end
