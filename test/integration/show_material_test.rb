require 'test_helper'

class ShowMaterialTest < ActionDispatch::IntegrationTest
  setup do
    @material = FactoryGirl.create( :material )
  end

  test "show material informations" do
    get "/materials/#{@material.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
