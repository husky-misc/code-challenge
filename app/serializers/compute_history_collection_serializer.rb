module Serializers
  class ComputeHistoryCollectionSerializer
    attr_accessor :data

    def initialize(compute_histories)
      @data = []
      compute_histories.each do |history|
        history_data = { ip_code: {}, computed_at: history.computed_at }
        history.ips.each { |ip| history_data[:ip_code][ip.address] = ip.values.join(',') }
        @data << history_data
      end
    end 
  end
end
