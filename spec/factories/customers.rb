# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  full_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :customer do
    full_name { Faker::Name.name[0..25] }
  end
end
