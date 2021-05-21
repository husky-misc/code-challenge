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

    class << self
      def possible?
        raise NotImplementedError
      end

      def priority
        PRIORITY_LEVEL[name.demodulize.to_sym]
      end

      def two_of_the_same(group)
        group.count { |deck| deck[:qty] == 2 }
      end

      def three_of_the_same(group)
        group.count { |deck| deck[:qty] == 3 }
      end

      def five_of_the_same(group)
        group.select { |deck| deck[:qty] >= 5 }
      end

      def five_consecutives?(faces)
        faces << 14 if faces[0] == 1

        (0..(faces.size - 5)).each do |i|
          return true if faces[i + 4] - faces[i] == 4
        end

        false
      end

      def to_s
        name.demodulize.underscore.dasherize
      end
    end
  end
end
