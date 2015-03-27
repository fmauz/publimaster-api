class ApplicationController < ActionController::API
	include ActionController::MimeResponds
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  before_filter :authenticate_user!

  def set_header_pagination( collection )
    response.header["X-Pagination-PerPage"] = collection.per_page.to_s
    response.headers["X-Pagination-TotalPages"] = collection.total_pages.to_s
    response.headers["X-Pagination-CurrentPage"] = collection.current_page.to_s
    response.headers["X-Pagination-totalItems"] = collection.total_entries.to_s
  end

  def default_serializer_options
    { root: false }
  end
end
