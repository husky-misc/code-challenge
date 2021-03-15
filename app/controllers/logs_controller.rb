class LogsController < ApplicationController
  before_action :set_log, only: %i[ show edit update destroy ]

  # GET /logs or /logs.json
  def index
    @logs = Log.all
  end

  # GET /logs/1 or /logs/1.json
  def show
  end

  # GET /logs/new
  def new
    @log = Log.new
  end

  # GET /logs/1/edit
  def edit
  end

  # POST /logs or /logs.json
  def create
    read_archive
    Stat.statistics
    redirect_to "/"
  end

  # PATCH/PUT /logs/1 or /logs/1.json
  def update
    respond_to do |format|
      if @log.update(log_params)
        format.html { redirect_to @log, notice: "Log was successfully updated." }
        format.json { render :show, status: :ok, location: @log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logs/1 or /logs/1.json
  def destroy
    @log.destroy
    respond_to do |format|
      format.html { redirect_to logs_url, notice: "Log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def read_archive
    match = []
    frag = []
    arq = File.open(log_params[:file])
    arq.each do |row|
      # debugger
      match_details = row.split(' ')
      if row.include?("New match")
        match_id = match_details[5] 
        match << match_id.to_i
      end
      if match_details.include?('killed') && !match_details.include?('<WORLD>')
        player_killer = match_details[3]
        gun = match_details.last
        player_dead = match_details[5]

        match << [player_killer, gun, player_dead]
      end
      if row.include?('ended')
        Log.create(
          match_id: match[0],
          player1: match[1][0],
          weapon: match[1][1],
          player2: match[1][2]
        )
        match = []
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def log_params
      params.require(:log).permit(:match_id, :player1, :player2, :weapon, :file)
    end
end
