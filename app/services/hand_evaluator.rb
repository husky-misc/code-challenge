# frozen_string_literal: true

class HandEvaluator < ApplicationService
  def initialize(hand)
    @hand = hand
  end

  def call
    {
      hand: @hand.visible_cards,
      deck: @hand.deck_cards,
      best_hand: best_hand
    }
  end

  def best_hand
    poker_hands.find do |poker_hand|
      poker_hand.possible?({
        sorted: @hand.sorted,
        by_face: @hand.grouped_by_face,
        by_suit: @hand.grouped_by_suit
      })
    end.to_s
  end

  def poker_hands
    @poker_hands ||= PokerHands::PokerHand.descendants.sort_by(&:priority)
  end
end
