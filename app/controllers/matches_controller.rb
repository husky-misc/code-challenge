class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def create
    ::Extractor::Parser.new(params[:file]).read

    redirect_to matches_path
  end
end
