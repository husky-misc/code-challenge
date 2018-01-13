class ComputesHistoryController < ApplicationController
  # GET /compute_history
  def index

    if params[:page] && params[:page][:number]
      raw_compute_history = ComputeHistory.paginate(page: params[:page][:number], per_page: 5)
      compute_history_log = []

      raw_compute_history.each do |log|
        compute_history_log << JSON.parse(log.result)
      end

      current_page = params[:page][:number]
    else
      raw_compute_history = ComputeHistory.all
      compute_history_log = []

      raw_compute_history.each do |log|
        compute_history_log << JSON.parse(log.result)
      end

      current_page = 0
    end

    total_pages = (ComputeHistory.count / 5.0).ceil
    pagination = {
      "first_page": 1,
      "current_page": current_page.to_i,
      "last_page": total_pages,
      "next_page_url": "http://localhost:3000/compute_history?page[number]=#{current_page.to_i+1}",
      "prev_page_url": "http://localhost:3000/compute_history?page[number]=#{current_page.to_i-1}"
    }
    
    render json: {history: compute_history_log, pagination: pagination}
  end
end
