class Ip < ApplicationRecord
  has_many :numbers, dependent: :destroy
  def numbers_value
    numbers = []
    self.numbers.each do |number|
      numbers << number.value
    end

    numbers.sort
  end
end
