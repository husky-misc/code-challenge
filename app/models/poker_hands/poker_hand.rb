# frozen_string_literal: true

module PokerHands
  class PokerHand
    PRIORITY_LEVEL = {
      StraightFlush: 0,
      FourOfAKind: 1,
      FullHouse: 2,
      Flush: 3,
      Straight: 4,
      ThreeOfAKind: 5,
      TwoPairs: 6,
      OnePair: 7,
      HighestCard: 8
    }.freeze

    def self.priority
      PRIORITY_LEVEL[name.demodulize.to_sym]
    end
  end
end
