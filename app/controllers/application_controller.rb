# frozen_string_literal: true

class ApplicationController < ActionController::API
  def current_account
    Account.find(params[:account_id])
  end
end
