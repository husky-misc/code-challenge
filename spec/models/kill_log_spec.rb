require 'rails_helper'

RSpec.describe KillLog, :type => :model do
    
    context('On a Match') do
        before(:each) do
            @kill_log = FactoryBot.create(:kill_log)            
          end
        it 'Should Create a log' do            
            expect(KillLog.count).to eq(1)
        end
        it 'Should have a killer' do
            expect(@kill_log.killer).to_not be_nil
        end
        it 'Should have a killed' do
            expect(@kill_log.killer).to_not be_nil
        end
        it 'Should have a gun' do
            expect(@kill_log.gun).to_not be_nil
        end
    end
end