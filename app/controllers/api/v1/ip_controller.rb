class Api::V1::IpController < ApplicationController

  # POST /api/v1/store
  def store
    ::Services::Store.new(params).call
    render json: { message: 'Your data has been stored.'}
  rescue ::Exceptions::MalformedInputError => e
    render json: { error: e.message }, status: :bad_request
  end

  # POST /api/v1/compute
  def compute
    compute_history = ::Services::Compute.new.call
    render json: ::Serializers::ComputeResultSerializer.new(compute_history)
  end

  # GET /api/v1/compute_histories
  def compute_histories
    histories_data = ::Services::GetComputeHistory.new(per: params[:per], page: params[:page]).call
    render json: ::Serializers::ComputeHistoryCollectionSerializer.new(histories_data)
  end
end
