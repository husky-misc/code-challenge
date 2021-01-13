# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  full_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_one(:account) }
  it { should validate_presence_of(:full_name) }
  it { should validate_length_of(:full_name).is_at_least(2).is_at_most(26) }
end
