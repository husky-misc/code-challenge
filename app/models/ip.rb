class Ip
  include Mongoid::Document

  field :address,  type: String
  field :values,   type: Array 
  
  validates_presence_of :address, :values
end
