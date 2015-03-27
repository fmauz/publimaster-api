require 'test_helper'

class ShowRetrancaTest < ActionDispatch::IntegrationTest
  setup do
    @retranca = FactoryGirl.create( :retranca )
  end

  test "show retranca informations" do
    get "/retrancas/#{@retranca.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
