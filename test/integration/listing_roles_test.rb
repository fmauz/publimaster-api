require 'test_helper'

class ListingRolesTest < ActionDispatch::IntegrationTest
  setup do
    FactoryGirl.create_list( :role, 10 )
  end

  test "listing all role" do
    get '/roles'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal Role.count, json( response.body )["roles"].size
  end
end
