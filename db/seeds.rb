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

puts '>>> Creating transactions'
puts '>>>>> Successful transactions'
FactoryBot.create_list(:transaction, 5, status: :paid, chargeable: matz.credit_cards.first)
FactoryBot.create_list(:transaction, 3, status: :paid, chargeable: sandi.credit_cards.first)
FactoryBot.create_list(:transaction, 1, status: :paid, chargeable: martin.credit_cards.first)
FactoryBot.create_list(:transaction, 1, status: :paid, chargeable: alan.credit_cards.first)

puts '>>>>> Failed transactions'
FactoryBot.create_list(:transaction, 3, status: :failed, chargeable: martin.credit_cards.first)
FactoryBot.create_list(:transaction, 2, status: :failed, chargeable: alan.credit_cards.first)


puts '>>>>> Dispute transactions'
FactoryBot.create_list(:transaction, 3, status: :disputed, chargeable: matz.credit_cards.first)
FactoryBot.create_list(:transaction, 2, status: :disputed, chargeable: sandi.credit_cards.first)
