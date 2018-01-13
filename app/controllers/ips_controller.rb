class IpsController < ApplicationController
  before_action :check_format, :check_params, :set_ip, only: [:create]

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
        @ip.numbers << number unless @ip.numbers.find_by value: value
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

    def ip_params
      params.require(:ip).permit(:address)
    end

    def check_format
      render nothing: true, status: 415 unless request.headers["Content-Type"] =~ /json/
    end

    def check_params
      if params[:address].blank? || params[:numbers].blank?
        render nothing: true, status: :bad_request
      elsif check_address(params[:address])
        render nothing: true, status: :bad_request
      end
    end

    def check_address(address)
      address.split('.').each do |portion|
        if portion.to_i < 0 || portion.to_i > 255 || portion.scan(/\D/).any?
          return true
        end
      end

      return false
    end

end
