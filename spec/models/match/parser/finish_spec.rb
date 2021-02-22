require 'rails_helper'

RSpec.describe Match::Parser::Finish do
  subject { Match::Parser::Finish.new(line) }

  let!(:match) { create(:match, match_id: "11348965") }

  describe 'Updates a match' do
    context 'With valid data' do
      let(:line) { "23/04/2013 15:34:22 - match 11348965 has ended" }

      it 'Save successfuly' do
        subject.save
        expect(Match.first.end_date).to eq DateTime.parse("23/04/2013 15:34:22")
      end
    end
  end
end