require 'rails_helper'

RSpec.describe MatchRecorderService do
  describe '.call' do
    context 'when file is empty' do
      let(:file_path) { Rails.root.join('spec', 'support', 'empty_log') }
      let(:file)      { File.open(file_path) }
      let(:service)   { MatchRecorderService.new(file) }

      it 'expects to not create matches' do
        expect(service.call).to be_empty
      end
    end

    context 'when file has an line without the data' do
      let(:file_path) { Rails.root.join('spec', 'support', 'corrupted_data_log') }
      let(:file)      { File.open(file_path) }
      let(:service)   { MatchRecorderService.new(file) }

      it 'expects to not create an match' do
        expect(service.call).to be_empty
      end
    end

    context 'when file has an line without the timestamp' do
      let(:file_path) { Rails.root.join('spec', 'support', 'corrupted_time_log') }
      let(:file)      { File.open(file_path) }
      let(:service)   { MatchRecorderService.new(file) }

      it 'expects to not create an match' do
        expect(service.call).to be_empty
      end
    end


    # expect to create a new match
    # context 'when match with the required regex to create a new match' do
    #   let(:match_id)    { '11348965' }
    #   let(:match_begin) { '23/04/2013 15:34:22'.to_time }
    #   let(:match_end)   { '23/04/2013 15:39:22'.to_time }
    #   let(:file_path)   { Rails.root.join('spec', 'support', 'new_match_log') }
    #   let(:file)        { File.open(file_path) }
    #   let(:service)     { MatchRecorderService.new(file) }
    #   let(:response) do
    #     [
    #       Match.new(
    #         match_id: match_id,
    #         match_begin: match_begin,
    #         match_end: match_end
    #       )
    #     ]
    #   end

    #   it 'expects to create a new match' do
    #     expect(service.call).to eq(response)
    #   end
    # end
  end
end
