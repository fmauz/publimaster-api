require 'test_helper'

class DestroyRetrancaTest < ActionDispatch::IntegrationTest
  setup do
    @retranca = FactoryGirl.create( :retranca )
  end

  test "destroy retranca" do
    delete "/retrancas/#{@retranca.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal Retranca.count, 0
  end
end
