require 'test_helper'

class DeletingSegmentTest < ActionDispatch::IntegrationTest
  setup do
    @segment = FactoryGirl.create( :segment )
  end

  test "destroy segment" do
    delete "/segments/#{@segment.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal Segment.count, 0
  end
end
