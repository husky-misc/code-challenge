class Customer < ApplicationRecord
  with_options presence: true do
    validates :first_name
    validates :last_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
