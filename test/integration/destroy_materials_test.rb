require 'test_helper'

class DestroyMaterialsTest < ActionDispatch::IntegrationTest
  setup do
    @material = FactoryGirl.create( :material )
  end

  test "destroy material" do
    delete "/materials/#{@material.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal Material.count, 0
  end
end
