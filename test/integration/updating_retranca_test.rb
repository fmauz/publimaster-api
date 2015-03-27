require 'test_helper'

class UpdatingRetrancaTest < ActionDispatch::IntegrationTest
  setup do
    @retranca = FactoryGirl.create( :retranca )
  end

  test "update retranca informations" do
    objectUpdated = { 
      retranca: FactoryGirl.attributes_for(:retranca)
    }

    put "/retrancas/#{@retranca.id}", objectUpdated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    retranca_object = Retranca.find( @retranca.id )

    assert_equal objectUpdated[:retranca][:name], retranca_object.name
    assert_equal objectUpdated[:retranca][:source], retranca_object.source
    assert_equal objectUpdated[:retranca][:body], retranca_object.body
    assert_equal objectUpdated[:retranca][:lead], retranca_object.lead
    assert_equal objectUpdated[:retranca][:column], retranca_object.column
    assert_equal objectUpdated[:retranca][:width], retranca_object.width
    assert_equal objectUpdated[:retranca][:height], retranca_object.height
    assert_equal objectUpdated[:retranca][:column_count], retranca_object.column_count
    assert_equal objectUpdated[:retranca][:column_width], retranca_object.column_width
  end
end
