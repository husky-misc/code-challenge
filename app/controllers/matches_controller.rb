class MatchesController < ApplicationController
  def index; end

  def new; end

  def create
    MatchRecorderService.new(
      File.open(allowed_params[:log])
    ).call
  end

  private

  def allowed_params
    params.permit(:log)
  end
end
