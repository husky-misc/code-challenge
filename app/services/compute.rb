module Services
  class Compute
    def call
      #mount computed
      compute_history     = ComputeHistory.new(computed_at: Time.now)
      compute_history.ips = group_by_address

      # save and destroy computed ips
      compute_history.save!
      destroy_all_ips

      compute_history
    end

    private

    def destroy_all_ips
      Ip.destroy_all
    end

    def group_by_address
      groups = ip_list.group_by(&:address)

      groups.map do |k, v|
        Ip.new(address: k, values: SortedSet.new(v.map(&:values).flatten).to_a)
      end 
    end

    def ip_list
      @ip_list ||= Ip.all
    end
  end
end