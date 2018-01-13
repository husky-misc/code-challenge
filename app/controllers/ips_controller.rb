class IpsController < ApplicationController
  # only accept json requests
  before_action :check_format, only: [:create]
  before_action :set_ip, only: [:create]

  # GET /compute
  def index
    raw_ips = Ip.all
    ips = []

    raw_ips.each do |ip|
      ips << { address: ip.address, numbers: ip.numbers_value }
    end

    Ip.destroy_all

    render json: ips
  end

  # POST /store
  def create
    @ip ||= Ip.new(ip_params)

    if @ip.save
      numbers = params[:numbers]
      numbers.each do |value|
        number = Number.new(value: value)
        @ip.numbers << number unless @ip.numbers.find_by value: number
      end
      render json: @ip, status: :created
    else
      render json: @ip.errors, status: :unprocessable_entity
    end
  end

  private

    def set_ip
      @ip = Ip.find_by address: params[:address]
    end

    # Only allow a trusted parameter "white list" through.
    def ip_params
      params.require(:ip).permit(:address)
    end

    def check_format
      puts request.headers["Content-Type"]
      render nothing: true, status: 415 unless request.headers["Content-Type"] =~ /json/
    end
end
