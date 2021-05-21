# frozen_string_literal: true

module PokerHands
  class TwoPairs < PokerHand
    def self.possible?(combination)
      two_of_the_same(combination[:by_face]) > 1
    end
  end
end
