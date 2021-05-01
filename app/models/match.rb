class Match < ApplicationRecord
  include Importable

  has_many :kills

  def rank
    RankQuery.new(self).call
  end
end
