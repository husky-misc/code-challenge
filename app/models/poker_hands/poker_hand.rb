# frozen_string_literal: true

module PokerHands
  class PokerHand
    PRIORITY_LEVEL = {
      StraightFlush: 1,
      FourOfAKind: 2,
      FullHouse: 3,
      Flush: 4,
      Straight: 5,
      ThreeOfAKind: 6,
      TwoPairs: 7,
      OnePair: 8,
      HighestCard: 9
    }.freeze

    def self.possible?
      raise NotImplementedError
    end

    def self.priority
      PRIORITY_LEVEL[name.demodulize.to_sym]
    end

    def self.two_of_the_same(group)
      group.count { |group| group[:qty] == 2 }
    end

    def self.three_of_the_same(group)
      group.count { |group| group[:qty] == 3 }
    end

    def self.five_of_the_same(group)
      group.select { |group| group[:qty] >= 5 }
    end

    def self.five_consecutives?(faces)
      faces << 14 if faces[0] == 1

      for i in 0..(faces.size - 5)
        return true if faces[i + 4] - faces[i] == 4
      end

      false
    end
  end
end
