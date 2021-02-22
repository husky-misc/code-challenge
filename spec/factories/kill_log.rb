FactoryBot.define do
    factory :kill_log do       
        match   { Match.create }
        association :killer, factory: :player
        association :killed, factory: :player
        association :gun, factory: :gun
    end
end