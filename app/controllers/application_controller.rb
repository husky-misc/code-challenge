class ApplicationController < ActionController::API
  # only accept json requests
  before_action :check

  def check
    render nothing: true, status: 415 if request.headers["Content-Type"] == nil
  end
end
