# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_one(:account) }
end
