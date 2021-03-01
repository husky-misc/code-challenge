# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  it { should belong_to(:game) }
end
