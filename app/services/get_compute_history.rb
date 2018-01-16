module Services
  class GetComputeHistory

    def initialize(page: , per:)
      @page = page.present? ? page : 1
      @per  = per.present? ? per : 5
    end

    def call
      compute_history
    end

    def compute_history
      ::ComputeHistory.order_by('computed_at' => 'desc').page(@page).per(@per)
    end
  end
end