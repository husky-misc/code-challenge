# frozen_string_literal: true

class GamesController < ApplicationController
  ACCEPTED_FORMAT = '.txt'

  def upload
    if valid_file?
      @result = GameAnalyzer.call(game_params[:games_filename])

      render :index, locals: { result: @result }
    else
      handle_error
    end
  rescue StandardError => e
    handle_error(e)
  end

  private

  def game_params
    params.permit(:games_filename)
  end

  def valid_file?
    return false unless game_params[:games_filename]

    File.extname(game_params[:games_filename]) == ACCEPTED_FORMAT
  end

  def handle_error(exception = nil)
    message = t('.unprocessable_file') if exception.nil?

    flash[:notice] = message || exception.message
    render :index, status: :unprocessable_entity
  end
end
