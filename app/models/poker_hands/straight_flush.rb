# frozen_string_literal: true

module PokerHands
  class StraightFlush < PokerHand
    def self.possible?(combination)
      eligible_suits = five_of_the_same(combination[:by_suit]).pluck(:suit)

      eligible_suits.any? do |suit|
        hand = flush_hand(combination[:sorted], suit)

        five_consecutives?(hand.map(&:face))
      end
    end

    def self.flush_hand(deck, suit)
      deck.select { |card| card.suit == suit }
    end
  end
end
