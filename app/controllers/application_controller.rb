class ApplicationController < ActionController::API
  include ExceptionHandler

  def pagination_info(collection)
    { total_pages: collection.total_pages, total_count: collection.total_count }
  end
end
