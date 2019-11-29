require 'rails_helper'

class Hash
    def json(parts)
        arr = parts.split(">")
        arr.reduce(self) do |memo, key|
            memo.fetch(key.to_s.strip) if memo
        end
    end
end

describe V1::BankStatementsController, type: :controller do
    it 'should request index and return 200 OK' do
        request.accept = 'application/vnd.api+json'
        get :index
        expect(response).to have_http_status(:ok)
    end

    it 'should request index and return 406 OK' do
        get :index
        expect(response).to have_http_status(:not_acceptable)
    end

    it 'GET v1/bank_statements/:id' do
        bank_statement = BankStatement.first
        
        request.accept = 'application/vnd.api+json'
        get :show, params: {id: bank_statement.id}
        
        response_body = JSON.parse(response.body)
        expect(response_body.json('data > id')).to eq(bank_statement.id.to_s)
        expect(response_body.json('data > type')).to eq('bank-statements')
        expect(response_body.json('data > attributes > total')).to eq(bank_statement.total.to_s)
    end
end