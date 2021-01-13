require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should belong_to(:customer) }
end
