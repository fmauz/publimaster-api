require 'test_helper'

class ListingSegmentsTest < ActionDispatch::IntegrationTest
  setup do
    FactoryGirl.create_list( :segment, 150 )
  end

  test "listing all segments" do
    get '/segments'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal Segment.count, json( response.body )["segments"].size
  end

  test "listing all segments with paginate" do
    get '/segments', { page: "1" }

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 30, json( response.body )["segments"].size
    assert_equal 30, response.headers["X-Pagination-PerPage"].to_i
    assert_equal 5, response.headers["X-Pagination-TotalPages"].to_i
    assert_equal 1, response.headers["X-Pagination-CurrentPage"].to_i
  end
end
