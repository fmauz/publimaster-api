require 'test_helper'

class ShowDiarioOficialTest < ActionDispatch::IntegrationTest
  setup do
    @diario_oficial = FactoryGirl.create( :diario_oficial )
  end

  test "show diario_oficial informations" do
    get "/diario_oficials/#{@diario_oficial.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end