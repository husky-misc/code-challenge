module Services
  class Compute
    def call
      group_by_address
    end

    private

    def group_by_address
      groups = ip_list.group_by(&:address)

      groups.map do |k, v|
        Ip.new(address: k, values: SortedSet.new(v.map(&:values).flatten).to_a, computed: true)
      end 
    end

    def ip_list
      @ip_list ||= Ip.all
    end
  end
end