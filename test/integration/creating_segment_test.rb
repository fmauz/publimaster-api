require 'test_helper'

class CreatingSegmentTest < ActionDispatch::IntegrationTest
  test "creating a new segment" do
    objectCreated = { 
      segment: FactoryGirl.attributes_for(:segment)
    }

    post "/segments", objectCreated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    segment_object = Segment.find( json( response.body )["segment"]["id"] )

    assert_equal objectCreated[:segment][:name], segment_object.name
  end

  test "creating a new segment with a invalid params" do
    invalidObject = { segment: { name: nil } }
    post "/segments", invalidObject, {}

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type

    jsonObject = json( response.body )

    assert jsonObject["name"].include? "can't be blank"
  end
end
