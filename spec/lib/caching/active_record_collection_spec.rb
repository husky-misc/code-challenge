require 'rails_helper'
require 'caching/active_record_collection.rb'

RSpec.describe 'Module ActiveRecordCollection' do

  include Caching::ActiveRecordCollection

  describe '.cache_block' do

    context 'When block is cached for the first time' do

      before do
        Rails.cache.write(cache_key_test, nil, expires_in: 1.minutes)
      end

      let(:cache_key_test) { "#{bank_account.cache_key_with_version}_all_transactions" }
      let(:bank_account) { create(:bank_account, :with_transactions, transactions_qt: 20) }

      it 'should cache block' do

        cache_block(record: bank_account, query: 'all_transactions') { bank_account.transactions }

        expect(Rails.cache.read(cache_key_test)).to eq bank_account.transactions.to_a
      end

      it 'cached block should be equal to return of method' do

        return_data = cache_block(record: bank_account, query: 'all_transactions') { bank_account.transactions }

        expect(Rails.cache.read(cache_key_test)).to eq return_data
      end
    end

    context 'When block is already cached' do

      before do
        @bank_account = create(:bank_account, :with_transactions, transactions_qt: 20)
        @cache_key_test = "#{@bank_account.cache_key_with_version}_all_transactions"
      end

      it 'should not update cache when method called many times' do

        cache_block(record: @bank_account, query: 'all_transactions') { @bank_account.transactions }

        3.times do
          cache_block(record: @bank_account, query: 'all_transactions') { ["Another content"] }
        end

        expect(Rails.cache.read(@cache_key_test)).to eq @bank_account.transactions.to_a
      end
    end

    context 'When model record of cached block is updated' do

      before do
        @bank_account = create(:bank_account, :with_transactions, transactions_qt: 20)
      end

      it 'should update cache when method called many times' do

        cache_block(record: @bank_account, query: 'all_transactions') { @bank_account.transactions }

        @bank_account.touch
        @cache_key_test = "#{@bank_account.cache_key_with_version}_all_transactions"

        3.times do
          cache_block(record: @bank_account, query: 'all_transactions') { ["Another content"] }
        end

        expect(Rails.cache.read(@cache_key_test)).to eq ["Another content"]
      end
    end
  end
end