require 'test_helper'

class CreatingClientTypeTest < ActionDispatch::IntegrationTest
  test "creating a new client_type" do
    objectCreated = {
      client_type: FactoryGirl.attributes_for(:client_type)
    }

    post "/client_types", objectCreated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    client_type_object = ClientType.find( json( response.body )["client_type"]["id"] )

    assert_equal objectCreated[:client_type][:name], client_type_object.name
  end

  test "creating a new client_type with a invalid params" do
    invalidObject = { client_type: { name: nil } }
    post "/client_types", invalidObject, {}

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type

    jsonObject = json( response.body )

    assert jsonObject["name"].include? "can't be blank"
  end
end
