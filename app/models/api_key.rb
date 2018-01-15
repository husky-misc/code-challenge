class ApiKey
  include Mongoid::Document

  field :token, type: String
end
