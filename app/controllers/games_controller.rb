# frozen_string_literal: true

class GamesController < ApplicationController
  ACCEPTED_FORMAT = '.txt'

  def upload
    if valid_file?
      @result = GameAnalyzer.call(game_params[:games_filename])

      render :index, locals: { result: @result }
    else
      flash[:notice] = t('.unprocessable_file')
      render :index, status: :unprocessable_entity
    end
  rescue GameAnalyzer::NoContentFile
    flash[:notice] = t('.no_content_file')
    render :index, status: :unprocessable_entity
  end

  private

  def game_params
    params.permit(:games_filename)
  end

  def valid_file?
    return false unless game_params[:games_filename]

    File.extname(game_params[:games_filename]) == ACCEPTED_FORMAT
  end
end
