# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hand, type: :model do
  describe '#straight_flush' do
    context 'when straight flush is possible' do
      it 'returns true'
    end

    context 'when straight flush is not possible' do
      it 'returns false'
    end
  end

  describe '#four_of_a_kind' do
    context 'when four of a kind is possible' do
      it 'returns true'
    end

    context 'when four of a kind is not possible' do
      it 'returns false'
    end
  end

  describe '#full_house' do
    context 'when full house is possible' do
      it 'returns true'
    end

    context 'when full house is not possible' do
      it 'returns false'
    end
  end

  describe '#flush' do
    context 'when flush is possible' do
      it 'returns true'
    end

    context 'when flush is not possible' do
      it 'returns false'
    end
  end

  describe '#straight' do
    context 'when straight is possible' do
      it 'returns true'
    end

    context 'when straight is not possible' do
      it 'returns false'
    end
  end

  describe '#three_of_a_kind' do
    context 'when three of a kind is possible' do
      it 'returns true'
    end

    context 'when three of a kind is not possible' do
      it 'returns false'
    end
  end

  describe '#two_pairs' do
    context 'when two pairs is possible' do
      it 'returns true'
    end

    context 'when two pairs is not possible' do
      it 'returns false'
    end
  end

  describe '#one_pair' do
    context 'when one pair is possible' do
      it 'returns true'
    end

    context 'when one pair is not possible' do
      it 'returns false'
    end
  end

  describe '#highest_card' do
    context 'when highest card is possible' do
      it 'returns true'
    end
  end
end
