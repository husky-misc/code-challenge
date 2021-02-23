class DashboardController < ApplicationController
  include DashboardHelper
  
  def index
  end

  def show
    @logs = get_ranking
    @global_log = get_global_ranking
  end

  def upload_file
    parse_log params[:file]
  end
end
