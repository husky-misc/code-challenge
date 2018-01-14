class Api::V1::IpController < ApplicationController

  def store
    ::Services::Store.new(params).call
  rescue ::Exceptions::MalformedInputException
    
  end
end
