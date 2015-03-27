require 'test_helper'

class DeletingJornalTest < ActionDispatch::IntegrationTest
  setup do
    @jornal = FactoryGirl.create( :jornal )
  end

  test "destroy jornal" do
    delete "/jornals/#{@jornal.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal Jornal.count, 0
  end
end
