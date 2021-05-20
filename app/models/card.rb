# frozen_string_literal: true

class Card
  class InvalidCard < StandardError; end

  SUITS = {
    'C' => 0, 'D' => 1, 'S' => 2, 'H' => 3
  }.freeze
  FACES = {
    'A' => 1, '2' =>  2, '3' =>  3, '4' =>  4,
    '5' => 5, '6' =>  6, '7' =>  7, '8' =>  8,
    '9' => 9, 'T' => 10, 'J' => 11, 'Q' => 12,
    'K' => 13
  }.freeze

  attr_accessor :face, :suit

  def self.build(card_string)
    card = new
    card.face = FACES[card_string[0]]
    card.suit = SUITS[card_string[1]]

    raise InvalidCard unless valid?(card_string, card)

    card
  end

  def self.valid?(input, card)
    return false if input.size != 2
    return false if card.face.nil?
    return false if card.suit.nil?

    true
  end

  private_class_method :valid?
end
