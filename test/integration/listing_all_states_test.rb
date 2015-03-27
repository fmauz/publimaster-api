require 'test_helper'

class ListingAllStatesTest < ActionDispatch::IntegrationTest
  setup do
    FactoryGirl.create_list( :state, 2 )
  end

  test "listing all states" do
    get '/states'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal State.count, json( response.body )["states"].size
  end
end
