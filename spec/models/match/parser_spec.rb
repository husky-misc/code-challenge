require 'rails_helper'

RSpec.describe Match::Parser do
  subject { Match::Parser.new(line) }

  describe 'New match line' do
    let(:line) { "23/04/2013 15:34:22 - New match 11348965 has started" }

    it 'Converts string date to datetime' do
      expect(subject.string_to_datetime).to eq DateTime.parse("23/04/2013 15:34:22")
    end
  end

  describe 'End match line' do
    context 'With valid data' do
      let(:line) { "23/04/2013 15:39:22 - Match 11348965 has ended" }

      it 'Finds correct data' do
        expect(subject.id).to eq "11348965"
      end

      it "Converts string date to datetime" do
        expect(subject.string_to_datetime).to eq DateTime.parse("23/04/2013 15:39:22")
      end
    end
  end
end