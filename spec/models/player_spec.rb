require 'rails_helper'

RSpec.describe Player, :type => :model do
    context('When valid') do
        it 'valid attributes'        
    end
    context('When invalid') do 
        it 'without a name'
        it 'without a unique name'
    end
end