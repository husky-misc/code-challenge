class ImportsController < ApplicationController
  def create
    render json: {}, status: :created
  end
end
