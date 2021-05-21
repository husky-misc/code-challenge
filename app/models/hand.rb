# frozen_string_literal: true

class Hand
  class InvalidHand < StandardError; end

  CARDS_AMOUNT = 10

  attr_accessor :cards, :visible_cards, :deck_cards

  class << self
    def build(deck_line)
      hand = new
      hand.cards = deck_line_parser(deck_line)
      hand.visible_cards = formatted_hand(deck_line)
      hand.deck_cards = formatted_deck(deck_line)

      raise InvalidHand unless valid?(hand)

      hand
    end

    def formatted_hand(deck_line)
      deck_line[..13]
    end

    def formatted_deck(deck_line)
      deck_line[15..]
    end

    def deck_line_parser(deck_line)
      deck_line.split.map { |value| Card.build(value) }
    end

    private

    def valid?(hand)
      return false if hand.cards.size != CARDS_AMOUNT
      return false if hand.cards.any? { |card| hand.cards.count(card) > 1 }

      true
    end
  end

  def sorted
    @sorted ||= cards.sort_by(&:face)
  end

  def grouped_by_face
    @grouped_by_face ||= cards.group_by(&:face).map do |face, cards|
      { face: face, qty: cards.size }
    end
  end

  def grouped_by_suit
    @grouped_by_suit ||= cards.group_by(&:suit).map do |suit, cards|
      { suit: suit, qty: cards.size }
    end
  end
end
