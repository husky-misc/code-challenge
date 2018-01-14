require 'rails_helper'

describe Services::Store, type: :service do
  
  describe '.call' do
    context 'when invalid IP address' do 
      let(:ip) do
        {
          'ip_list': [
            '1.1.1.a: 1,2,3'
          ]
        }.as_json
      end

      it 'should return MalformedInputError' do
        expect { described_class.new(ip).call }.to raise_error(::Exceptions::MalformedInputError) 
      end
    end

    context 'when valid IP address' do
      let(:ip) do
        {
          'ip_list': [
            '1.1.1.1: 1,2,3'
          ]
        }.as_json
      end
      before {
        described_class.new(ip).call
      }
      it { expect(::Ip.count).to eq(1) }
    end
  end
end