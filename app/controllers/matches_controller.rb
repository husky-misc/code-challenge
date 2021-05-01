class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end
end
