class ApplicationController < ActionController::API
	include ActionController::MimeResponds
  include ActionController::Serialization
  include DeviseTokenAuth::Concerns::SetUserByToken
  
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
