class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { message: e.message }, status: :unprocessable_entity
  end

def pagination_dict(collection)
  {
    current_page: collection.current_page,
    next_page: collection.next_page,
    prev_page: collection.prev_page, # use collection.previous_page when using will_paginate
    total_pages: collection.total_pages,
    total_count: collection.total_count
  }
end
end
