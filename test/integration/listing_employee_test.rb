require 'test_helper'

class ListingEmployeeTest < ActionDispatch::IntegrationTest
  setup do
    FactoryGirl.create_list( :employee, 35 )
  end

  test "listing all employees" do
    get '/employees', page: 1

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 30, json( response.body )["employees"].size
    assert_equal 30, response.headers["X-Pagination-PerPage"].to_i
    assert_equal 2, response.headers["X-Pagination-TotalPages"].to_i
    assert_equal 1, response.headers["X-Pagination-CurrentPage"].to_i
  end
end
