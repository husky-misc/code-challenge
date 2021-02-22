require 'rails_helper'

RSpec.describe Frags::Parser do
  let!(:match) { create(:match, match_id: "11348965") }
  subject { Frags::Parser.new(line, match) }

  describe 'New killed line' do
    context 'With valid data' do
      let(:line) { "23/04/2013 15:36:04 - Roman killed Nick using M16" }

      it 'Converts string date to datetime' do
        expect(subject.string_to_datetime).to eq DateTime.parse("23/04/2013 15:36:04")
      end
    end
  end
end