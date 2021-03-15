class StatsController < ApplicationController
  before_action :set_stat, only: %i[show edit update destroy]

  # GET /stats or /stats.json
  def index
    # @stats = Stat.all
    @stats = Stat.kills_death
  end

  # GET /stats/1 or /stats/1.json
  def show; end

  # GET /stats/new
  def new
    @stat = Stat.new
  end

  # GET /stats/1/edit
  def edit; end

  # POST /stats or /stats.json
  def create
  end

  # PATCH/PUT /stats/1 or /stats/1.json
  def update
  end

  # DELETE /stats/1 or /stats/1.json
  def destroy
    @stat.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stat
    @stat = Stat.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stat_params
    params.require(:stat).permit(:player, :kills, :death)
  end
end
