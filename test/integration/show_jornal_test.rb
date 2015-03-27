require 'test_helper'

class ShowJornalTest < ActionDispatch::IntegrationTest
  setup do
    @jornal = FactoryGirl.create( :jornal )
  end

  test "show jornal informations" do
    get "/jornals/#{@jornal.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
