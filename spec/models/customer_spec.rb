require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_one(:account) }
end
