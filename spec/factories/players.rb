FactoryBot.define do
  factory :player do
    name { 'Gidex' }
    frags { 10 }
    deads { 3 }
    awarded { true }
    strong_weapon { 'AK47' }
    strong_killer { true }
    score { 350 }
  end
end
