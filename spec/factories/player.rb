FactoryBot.define do
    factory :player do
        name { Faker::Games::Fallout.unique.character}
    end
end