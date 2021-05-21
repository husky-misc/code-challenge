# frozen_string_literal: true

module PokerHands
  class ThreeOfAKind < PokerHand
    def self.possible?(combination)
      three_of_the_same(combination[:by_face]).positive?
    end
  end
end
