require 'test_helper'

class UpdateDiarioOficialTest < ActionDispatch::IntegrationTest
  setup do
    @diario_oficial = FactoryGirl.create( :diario_oficial )
    @state = FactoryGirl.create(:state)
  end

  test "update diario_oficial informations" do
    objectUpdated = { 
      diario_oficial: FactoryGirl.attributes_for(:diario_oficial, state_id: @state.id)
    }

    put "/diario_oficials/#{@diario_oficial.id}", objectUpdated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    diario_oficial_object = DiarioOficial.find( @diario_oficial.id )

    assert_equal objectUpdated[:diario_oficial][:name], diario_oficial_object.name
    assert_equal objectUpdated[:diario_oficial][:contact], diario_oficial_object.contact
    assert_equal objectUpdated[:diario_oficial][:observation], diario_oficial_object.observation
    assert_equal objectUpdated[:diario_oficial][:state_id], diario_oficial_object.state.id
    assert_equal objectUpdated[:diario_oficial][:schedule], diario_oficial_object.schedule
    assert_equal objectUpdated[:diario_oficial][:source], diario_oficial_object.source
    assert_equal objectUpdated[:diario_oficial][:body], diario_oficial_object.body
    assert_equal objectUpdated[:diario_oficial][:lead], diario_oficial_object.lead
    assert_equal objectUpdated[:diario_oficial][:column], diario_oficial_object.column
    assert_equal objectUpdated[:diario_oficial][:width], diario_oficial_object.width
    assert_equal objectUpdated[:diario_oficial][:height], diario_oficial_object.height
    assert_equal objectUpdated[:diario_oficial][:column_count], diario_oficial_object.column_count
    assert_equal objectUpdated[:diario_oficial][:column_width], diario_oficial_object.column_width
  end
end
