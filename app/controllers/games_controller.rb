# frozen_string_literal: true

class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      StoreMatchService.call(@game)

      flash[:notice] = 'Upload realizado com Sucesso!'
      redirect_to games_path
    else
      flash[:alert] = @game.errors[:file].first
      render :new
    end
  end

  def index
    @game = CreateGlobalRankingService.call.sort_by(&:frags).reverse
  end

  private

  def game
    params[:game]
  end

  def game_params
    params.require(:game).permit(:file)
  end
end
