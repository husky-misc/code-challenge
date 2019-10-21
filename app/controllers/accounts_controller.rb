class AccountsController < ApplicationController
  def create
    account = Account.create!

    render json: account, status: :created
  end
end
