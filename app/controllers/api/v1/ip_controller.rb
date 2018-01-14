class Api::V1::IpController < ApplicationController

  def store
    ::Services::Store.new(params).call
    render json: { message: 'ok'}, status: :ok
  rescue ::Exceptions::MalformedInputException => e
    render json: { error: e.message }
  end

  def compute
    computed_data = ::Services::Compute.new.call
    render json: computed_data
  end
end
