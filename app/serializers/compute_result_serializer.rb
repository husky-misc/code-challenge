module Serializers
  class ComputeResultSerializer
    attr_accessor :data

    def initialize(compute_history)
      @data = { ip_code: {} }
      compute_history.ips.each { |ip| @data[:ip_code][ip.address] = ip.values.join(',') }
    end
  end
end