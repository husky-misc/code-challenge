customers = [
  { first_name: 'Yukihiro', last_name: 'Matsumoto' },
  { first_name: 'Sandi', last_name: 'Matz' },
  { first_name: 'Martin', last_name: 'Fowler' },
  { first_name: 'Dr. Alan', last_name: 'Kay' }
]

puts '########################################'
puts '>>> Adding new Customers to the system'

customers.each do |customer|
  FactoryBot.create(:customer, first_name: customer[:first_name], last_name: customer[:last_name])
end
