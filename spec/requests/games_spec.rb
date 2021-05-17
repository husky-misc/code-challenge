# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games', type: :request do
  describe 'POST /games_upload' do
    context 'when all cards are valid' do
      it 'returns a success response'
      it 'returns the best hand within deck'
    end

    context 'when file format is invalid' do
      it 'raises an error'
    end

    context 'when data is invalid' do
      it 'returns with an error message for the line'
    end
  end
end
