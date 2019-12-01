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
    it 'GET v1/bank_statements/:id/transactions' do
        bank_statement = BankStatement.first

        request.accept = 'application/vnd.api+json'
        get :show, params: {id: bank_statement.id}

        expect(response).to have_http_status(:ok)
    end
    context 'Testing API caching with Russian Doll strategy' do
        before do
            request.accept = 'application/vnd.api+json'
            get :index
            @last_modified = response.headers['Last-Modified']
        end
        context "if it is not stale" do
            before do
                request.env['HTTP_IF_MODIFIED_SINCE'] = @last_modified
            end
            it "should request index and return 304" do
                request.accept = 'application/vnd.api+json'
                get :index
                expect(response).to have_http_status(:not_modified)
            end
        end
        context "if it has been updated" do
            before do
                sleep 2 # To ensure the updated_at has a delta of at least 2 sec
                request.env['HTTP_IF_MODIFIED_SINCE'] = @last_modified
                @bank_statement = BankStatement.last
            end
            it "DELETE v1/bank_statements/:id/" do
                
                request.accept = 'application/vnd.api+json'
                request.content_type = 'application/vnd.api+json'
               
                delete :destroy, params: { id: @bank_statement.id }
                @last_modified = response.headers['Last-Modified']

                expect(response).to have_http_status(:no_content)
            end
        end
        context "getting bank statements updated" do
            it "should return 200 in the new request" do
                request.accept = 'application/vnd.api+json'
                get :index
                expect(response).to have_http_status(:ok)
            end
        end
    end
end