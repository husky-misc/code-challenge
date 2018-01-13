class ComputesHistoryController < ApplicationController
  # GET /compute_history
  def index
    raw_compute_history = ComputeHistory.all
    compute_history_log = []
    
    raw_compute_history.each do |log|
      compute_history_log << JSON.parse(log.result)
    end

    render json: compute_history_log
  end
end
