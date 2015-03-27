require 'test_helper'

class CreatingMaterialsTest < ActionDispatch::IntegrationTest

  test "creating a new material" do
    objectCreated = { 
      material: FactoryGirl.attributes_for(:material)
    }

    post "/materials", objectCreated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    material_object = Material.find( json( response.body )["material"]["id"] )

    assert_equal objectCreated[:material][:name], material_object.name
  end

  test "creating a new material with a invalid params" do
    invalidObject = { material: { name: nil } }
    post "/materials", invalidObject, {}

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type

    jsonObject = json( response.body )

    assert jsonObject["name"].include? "can't be blank"
  end
end
