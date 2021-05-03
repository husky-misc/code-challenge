class Match < ApplicationRecord
  has_many :kills

  def rank
    RankQuery.new(self).call
  end
end
