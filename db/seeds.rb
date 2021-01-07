puts '####################'
puts '||GENERATING SEEDS||'
puts '####################'

puts '>>> Creating customers and accounts'
matz = FactoryBot.create(:customer, :with_account, first_name: 'Yukihiro', last_name: 'Matsumoto')
sandi = FactoryBot.create(:customer, :with_account, first_name: 'Sandi', last_name: 'Matz')
martin = FactoryBot.create(:customer, :with_account, first_name: 'Martin', last_name: 'Fowler')
alan = FactoryBot.create(:customer, :with_account, first_name: 'Dr. Alan', last_name: 'Kay')

puts '>>> Creating credit cards'
FactoryBot.create(:credit_card, account: matz.account)
FactoryBot.create(:credit_card, account: sandi.account)
FactoryBot.create(:credit_card, account: martin.account)
FactoryBot.create(:credit_card, account: alan.account)

