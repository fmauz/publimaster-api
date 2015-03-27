require 'test_helper'

class CreatingJornalTest < ActionDispatch::IntegrationTest
  setup do
    @state = FactoryGirl.create( :state )
  end

  test "creating a new client" do
    objectCreated = { 
      jornal: {
        name: Faker::Company.name,
        contact: Faker::Name.name,
        observation: Faker::Lorem.paragraph(2),
        state_id: @state.id
      }
    }

    post "/jornals", objectCreated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    jornal_object = Jornal.find( json( response.body )["jornal"]["id"] )

    assert_equal objectCreated[:jornal][:name], jornal_object.name
    assert_equal objectCreated[:jornal][:contact], jornal_object.contact
    assert_equal objectCreated[:jornal][:observation], jornal_object.observation
    assert_equal objectCreated[:jornal][:state_id], jornal_object.state.id
  end

  test "creating a new client with a invalid params" do
    invalidObject = { jornal: { observation: Faker::Lorem.paragraph(2) } }
    post "/jornals", invalidObject, {}

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type

    jsonObject = json( response.body )

    assert jsonObject["name"].include? "can't be blank"
    assert jsonObject["state"].include? "can't be blank"
  end
end