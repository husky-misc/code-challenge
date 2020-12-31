class Api::V1::ApiBaseController < ApplicationController
  WillPaginate.per_page = 5
end
