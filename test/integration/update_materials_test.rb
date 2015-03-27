require 'test_helper'

class UpdateMaterialsTest < ActionDispatch::IntegrationTest
  setup do
    @material = FactoryGirl.create( :material )
  end

  test "update material informations" do
    objectUpdated = { 
      material: FactoryGirl.attributes_for(:material)
    }

    put "/materials/#{@material.id}", objectUpdated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    material_object = Material.find( @material.id )

    assert_equal objectUpdated[:material][:name], material_object.name
  end
end
