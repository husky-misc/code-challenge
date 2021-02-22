require 'rails_helper'

RSpec.describe Match::Parser::Start do
  subject { Match::Parser::Start.new(line) }

  describe 'Creates a match' do
    context 'With valid data' do
      let(:line) { "23/04/2013 15:34:22 - New match 11348965 has started" }

      it 'Saves successfuly' do
        expect { subject.save }.to change { Match.count }.from(0).to(1)
      end
    end
  end
end