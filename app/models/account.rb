class Account < ApplicationRecord
  belongs_to :customer, required: true

  validates :customer_id, uniqueness: :true
end
