class Match < ApplicationRecord
  include Importable

  has_many :kills
end
