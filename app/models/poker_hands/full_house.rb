# frozen_string_literal: true

module PokerHands
  class FullHouse < PokerHand
    def self.possible?(combination)
      threes = three_of_the_same(combination[:by_face])

      two_of_the_same(combination[:by_face]) + threes > 1 &&
        threes > 0
    end

    def self.to_s
      'full-house'
    end
  end
end
