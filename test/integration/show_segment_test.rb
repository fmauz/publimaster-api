require 'test_helper'

class ShowSegmentTest < ActionDispatch::IntegrationTest
  setup do
    @segment = FactoryGirl.create( :segment )
  end

  test "show segment informations" do
    get "/segments/#{@segment.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
