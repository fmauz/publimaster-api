require 'test_helper'

class ListingClientTypeTest < ActionDispatch::IntegrationTest
  setup do
    FactoryGirl.create_list( :client_type, 35 )
  end

  test "listing all client types" do
    get '/client_types'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal ClientType.count, json( response.body )["client_types"].size
  end

  test "listing all client types with pagination" do
    get '/client_types', page: 1

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 30, json( response.body )["client_types"].size
    assert_equal 30, response.headers["X-Pagination-PerPage"].to_i
    assert_equal 2, response.headers["X-Pagination-TotalPages"].to_i
    assert_equal 1, response.headers["X-Pagination-CurrentPage"].to_i
  end
end
