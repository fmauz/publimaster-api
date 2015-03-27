require 'test_helper'

class ListingStreetSuffixesTest < ActionDispatch::IntegrationTest
  setup do
    FactoryGirl.create_list( :street_suffix, 35 )
  end

  test "listing all street suffixes" do
    get '/street_suffixes'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal StreetSuffix.count, json( response.body )["street_suffixes"].size
  end

  test "listing all street suffixes with pagination" do
    get '/street_suffixes', page: 1

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 30, json( response.body )["street_suffixes"].size
    assert_equal 30, response.headers["X-Pagination-PerPage"].to_i
    assert_equal 2, response.headers["X-Pagination-TotalPages"].to_i
    assert_equal 1, response.headers["X-Pagination-CurrentPage"].to_i
  end
end
