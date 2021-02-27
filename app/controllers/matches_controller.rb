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

    Rails.logger.info('The matches has been successfully created')
    redirect_to(matches_path)
  rescue StandardError => e
    Rails.logger.error("#{e}: The matches has not been successfully created")
    redirect_to(matches_path)
  end

  def show
    match = Matches::MatchRepository.match_plays(allowed_params[:id])
    @presenter = Matches::ShowPresenter.new(match).attributes
  end

  private

  def allowed_params
    params.permit(:log, :id)
  end
end
