# frozen_string_literal: true

module PokerHands
  class OnePair < PokerHand
    def self.possible?(combination)
      two_of_the_same(combination[:by_face]).positive?
    end
  end
end
