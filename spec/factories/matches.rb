FactoryBot.define do
  factory :match do
    association :ranking

    frags { 50 }
    match_code { 50 }
    started_at { '2021-05-15 08:30' }
    ended_at { '2021-05-15 09:30' }
    winner { 'Gidex' }
    content do
      '[{"datetime":"24/04/2020 16:14:22","log_item":" New match 11348961 has started"},
      {"datetime":"24/04/2020 16:26:12","log_item":" Roman killed Marcus using M16"},
      {"datetime":"24/04/2020 16:35:56","log_item":" Marcus killed Jhon using AK47"},
      {"datetime":"24/04/2020 17:12:34","log_item":" Roman killed Bryian using M16"},
      {"datetime":"24/04/2020 18:26:14","log_item":" Bryan killed Marcus using AK47"},
      {"datetime":"24/04/2020 19:36:33","log_item":" \\u003cWORLD\\u003e killed Marcus by DROWN"},
      {"datetime":"24/04/2020 20:19:22","log_item":" Match 11348961 has ended"}]'
    end
    strike_player { true }
  end
end
