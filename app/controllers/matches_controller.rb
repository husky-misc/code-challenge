class MatchesController < ApplicationController
  def index
    @matches = Match.all
    @players = Player.global_ranking
  end

  def create
    ::Extractor::Parser.new(params[:file]).read

    redirect_to matches_path
  end

  def show
    @match = Match.find(params[:id])
    @players = @match.ranking
  end
end
