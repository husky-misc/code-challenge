FactoryBot.define do
  factory :player do
    nickname { Faker::Name.name }
  end
end
