require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Factory' do
    context 'When create transaction Factory' do
      it 'should create without error' do
        2.times do
          expect(create(:transaction)).to be_truthy
        end
      end

      it 'should have description' do
        expect(create(:transaction).description).not_to be_nil
      end

      it 'should have description' do
        expect(create(:transaction).amount).not_to be_nil
      end
    end

    context 'When create with :type_credit' do
      it 'should be credit' do
        expect(create(:transaction, :type_credit).credit?).to be_truthy
      end
    end

    context 'When create with :type_debit' do
      it 'should be debit' do
        expect(create(:transaction, :type_debit).debit?).to be_truthy
      end
    end
  end
end
