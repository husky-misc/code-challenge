FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  trait :with_account do
    after(:create) do |customer|
      FactoryBot.create(:account, customer: customer)
    end
  end
end
