RSpec.describe "Gun", :type => :model do
    it 'Should have a name' do
        gun = FactoryBot.build(:gun)
        expect(gun).to be_valid
    end
    context('Shoub be invalid') do 
        it 'without a name' do
            gun = FactoryBot.build(:gun, name: "")
            expect(gun).to_not be_valid
        end
    end
end