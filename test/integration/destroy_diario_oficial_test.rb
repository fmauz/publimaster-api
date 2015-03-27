require 'test_helper'

class DestroyDiarioOficialTest < ActionDispatch::IntegrationTest
  setup do
    @diario_oficial = FactoryGirl.create( :diario_oficial )
  end

  test "destroy diario_oficial" do
    delete "/diario_oficials/#{@diario_oficial.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal DiarioOficial.count, 0
  end
end
