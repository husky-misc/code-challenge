class ComputesHistoryController < ApplicationController
  # GET /compute_history
  def index
    if params[:page] && params[:page][:number]
      raw_compute_history = ComputeHistory.paginate(page: params[:page][:number], per_page: 5)
      current_page = params[:page][:number]
    else
      raw_compute_history = ComputeHistory.all
      current_page = 0
    end
    total_pages = (ComputeHistory.count / 5.0).ceil

    compute_history_log = serialize(raw_compute_history)
    pagination = create_pagination(current_page, total_pages)
    render json: {history: compute_history_log, pagination: pagination}
  end


  private

    def serialize(raw_log)
      history_log = []
      raw_log.each do |log|
        history_log << JSON.parse(log.result)
      end

      history_log
    end

    def create_pagination(current_page, total_pages)
      pagination = {
        "first_page": 1,
        "current_page": current_page.to_i,
        "last_page": total_pages,
        "next_page_url": "http://localhost:3000/compute_history?page[number]=#{current_page.to_i+1}",
        "prev_page_url": "http://localhost:3000/compute_history?page[number]=#{current_page.to_i-1}"
      }
    end
end
