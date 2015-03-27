require 'test_helper'

class CreatingRetrancaTest < ActionDispatch::IntegrationTest
  test "creating a new retranca" do
    objectCreated = { 
      retranca: FactoryGirl.attributes_for(:retranca)
    }

    post "/retrancas", objectCreated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    retranca_object = Retranca.find( json( response.body )["retranca"]["id"] )

    assert_equal objectCreated[:retranca][:name], retranca_object.name
    assert_equal objectCreated[:retranca][:source], retranca_object.source
    assert_equal objectCreated[:retranca][:body], retranca_object.body
    assert_equal objectCreated[:retranca][:lead], retranca_object.lead
    assert_equal objectCreated[:retranca][:column], retranca_object.column
    assert_equal objectCreated[:retranca][:width], retranca_object.width
    assert_equal objectCreated[:retranca][:height], retranca_object.height
    assert_equal objectCreated[:retranca][:column_count], retranca_object.column_count
    assert_equal objectCreated[:retranca][:column_width], retranca_object.column_width
  end

  test "creating a new client with a invalid params" do
    invalidObject = { retranca: { name: nil } }
    post "/retrancas", invalidObject, {}

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type

    jsonObject = json( response.body )

    assert jsonObject["name"].include? "can't be blank"
  end
end
