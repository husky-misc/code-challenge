require 'rails_helper'

RSpec.describe Frags::Parser::ByPlayer do
  let!(:match) { create(:match, match_id: "11348965") }
  let!(:player) { create(:player, name: 'Roman') }
  let!(:player_2) { create(:player, name: 'Nick') }
  subject { Frags::Parser::ByPlayer.new(line, match) }

  describe 'Creates a frag' do
    context 'With valid data' do
      let(:line) { "23/04/2013 15:34:22 - Roman killed Nick using M16" }

      it 'Saves successfuly' do
        expect { subject.save }.to change { Frag.count }.from(0).to(1)
      end

      it 'Does not duplicate frags' do
        expect { subject.save }.to change { Frag.count }.from(0).to(1)
        expect { subject.save }.to_not change { Frag.count }
      end
    end

    context 'Creates frag with an existing player' do
      let(:line) { "23/04/2013 15:34:22 - Roman killed Nick using M16" }

      it 'Saves successfuly' do
        expect { subject.save }.not_to change { Player.count }
      end
    end
  end
end