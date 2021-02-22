require 'rails_helper'

RSpec.describe Extractor::ExtractData do
  let(:line) do
      "23/04/2013 15:34:22 - New match 11348965 has started
      23/04/2013 15:36:04 - Roman killed Nick using M16
      23/04/2013 15:36:33 - <WORLD> killed Nick by DROWN
      23/04/2013 15:39:22 - Match 11348965 has ended"
  end

  subject { Extractor::ExtractData.new(line) }

  context 'Reading a file' do
    it 'Creates a match' do
      expect{ subject.extract }.to change { ::Match.count }.from(0).to(1)
    end

    it 'Creates a gun' do
      expect{ subject.extract }.to change { ::Gun.count }.from(0).to(2)
    end

    it 'Creates a frag' do
      expect{ subject.extract }.to change { ::Frag.count }.from(0).to(1)
    end

    it 'Creates a death' do
      expect{ subject.extract }.to change { ::Death.count }.from(0).to(2)
    end

    it 'Creates a player' do
      expect{ subject.extract }.to change { ::Player.count }.from(0).to(2)
    end
  end
end