# frozen_string_literal: true

module PokerHands
  class FourOfAKind < PokerHand
    def self.possible?(combinations)
      combinations[:by_face].any? { |group| group[:qty] == 4 }
    end
  end
end
