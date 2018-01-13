class Ip
  include Mongoid::Document

  field :address, type: String
  field :values,  type: Array 
end
