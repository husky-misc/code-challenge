class MatchesController < ApplicationController
  def index
    matches = Matches::ResumeRepository.matches
    @presenter = Matches::IndexPresenter.new(matches).attributes
  end

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
