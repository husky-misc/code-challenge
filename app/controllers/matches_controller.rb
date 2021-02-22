class MatchesController < ApplicationController
  def index
    @matches = Match.all
    @players = Player.global_ranking
  end

  def create
    return redirect_to new_match_path unless params[:file].present?

    ::Extractor::Parser.new(params[:file]).read

    redirect_to matches_path
  end

  def show
    @match = Match.find(params[:id])
    @players = @match.ranking
  end
end
