class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_one :account
end
