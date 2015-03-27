require 'test_helper'

class UpdateSegmentTest < ActionDispatch::IntegrationTest
  setup do
    @segment = FactoryGirl.create( :segment )
  end

  test "update segment informations" do
    objectUpdated = { 
      segment: FactoryGirl.attributes_for(:segment)
    }

    put "/segments/#{@segment.id}", objectUpdated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    segment_object = Segment.find( @segment.id )

    assert_equal objectUpdated[:segment][:name], segment_object.name
  end
end
