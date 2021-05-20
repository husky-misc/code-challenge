# frozen_string_literal: true

class Hand
  class InvalidHand < StandardError; end

  CARDS_AMOUNT = 10

  attr_accessor :deck_by_face, :deck_by_suit, :visible_cards, :deck_cards

  def self.build(deck_line)
    cards = deck_line_parser(deck_line)

    hand = new
    hand.deck_by_face = cards.sort_by(&:face)
    hand.deck_by_suit = cards.sort_by(&:suit)
    hand.visible_cards = formatted_hand(deck_line)
    hand.deck_cards = formatted_deck(deck_line)

    raise InvalidHand unless valid?(hand)

    hand
  end

  def self.formatted_hand(deck_line)
    deck_line[..13]
  end

  def self.formatted_deck(deck_line)
    deck_line[15..]
  end

  def self.deck_line_parser(deck_line)
    deck_line.split.map { |value| Card.build(value) }
  end

  def self.valid?(hand)
    return false if hand.deck_by_face.size != CARDS_AMOUNT

    true
  end

  private_class_method :deck_line_parser, :valid?
end
