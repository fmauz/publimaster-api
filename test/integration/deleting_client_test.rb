require 'test_helper'

class DeletingClientTest < ActionDispatch::IntegrationTest
  setup do
    @client = FactoryGirl.create( :client )
  end

  test "listing all clients" do
    delete "/clients/#{@client.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal Client.count, 0
  end
end
