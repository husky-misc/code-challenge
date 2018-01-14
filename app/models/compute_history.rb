class ComputeHistory
  include Mongoid::Document
  embeds_many :ips
  field :computed_at, type: DateTime

  validates_presence_of :computed_at
end
