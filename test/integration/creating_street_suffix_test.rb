require 'test_helper'

class CreatingStreetSuffixTest < ActionDispatch::IntegrationTest
  test "creating a new segment" do
    objectCreated = {
      street_suffix: FactoryGirl.attributes_for(:street_suffix)
    }

    post "/street_suffixes", objectCreated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    street_suffix_object = StreetSuffix.find( json( response.body )["street_suffix"]["id"] )

    assert_equal objectCreated[:street_suffix][:name], street_suffix_object.name
  end

  test "creating a new segment with a invalid params" do
    invalidObject = { street_suffix: { name: nil } }
    post "/street_suffixes", invalidObject, {}

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type

    jsonObject = json( response.body )

    assert jsonObject["name"].include? "can't be blank"
  end
end
