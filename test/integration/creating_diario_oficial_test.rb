require 'test_helper'

class CreatingDiarioOficialTest < ActionDispatch::IntegrationTest
  setup do
    @state = FactoryGirl.create( :state )
  end

  test "creating a new diario oficial" do
    objectCreated = { 
      diario_oficial: FactoryGirl.attributes_for(:diario_oficial)
    }

    objectCreated[:diario_oficial][:state_id] = @state.id

    post "/diario_oficials", objectCreated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    diario_oficial_object = DiarioOficial.find( json( response.body )["diario_oficial"]["id"] )

    assert_equal objectCreated[:diario_oficial][:name], diario_oficial_object.name
    assert_equal objectCreated[:diario_oficial][:contact], diario_oficial_object.contact
    assert_equal objectCreated[:diario_oficial][:observation], diario_oficial_object.observation
    assert_equal objectCreated[:diario_oficial][:state_id], diario_oficial_object.state.id
    assert_equal objectCreated[:diario_oficial][:schedule], diario_oficial_object.schedule
    assert_equal objectCreated[:diario_oficial][:source], diario_oficial_object.source
    assert_equal objectCreated[:diario_oficial][:body], diario_oficial_object.body
    assert_equal objectCreated[:diario_oficial][:lead], diario_oficial_object.lead
    assert_equal objectCreated[:diario_oficial][:column], diario_oficial_object.column
    assert_equal objectCreated[:diario_oficial][:width], diario_oficial_object.width
    assert_equal objectCreated[:diario_oficial][:height], diario_oficial_object.height
    assert_equal objectCreated[:diario_oficial][:column_count], diario_oficial_object.column_count
    assert_equal objectCreated[:diario_oficial][:column_width], diario_oficial_object.column_width
  end

  test "creating a new client with a invalid params" do
    invalidObject = { diario_oficial: { observation: Faker::Lorem.paragraph(2) } }
    post "/diario_oficials", invalidObject, {}

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type

    jsonObject = json( response.body )

    assert jsonObject["name"].include? "can't be blank"
    assert jsonObject["state"].include? "can't be blank"
  end
end
