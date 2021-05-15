FactoryBot.define do
  factory :user do
    email { 'email.test@gmail.com' }
    password_digest { '1111111111' }
  end
end
