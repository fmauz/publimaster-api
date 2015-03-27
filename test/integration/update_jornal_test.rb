require 'test_helper'

class UpdateJornalTest < ActionDispatch::IntegrationTest
  setup do
    @jornal = FactoryGirl.create( :jornal )

    @state = FactoryGirl.create(:state)
  end

  test "update jornal informations" do
    objectUpdated = { 
      jornal: {
        name: Faker::Company.name,
        contact: Faker::Name.name,
        observation: Faker::Lorem.paragraph(2),
        state_id: @state.id
      }
    }

    put "/jornals/#{@jornal.id}", objectUpdated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    jornal_object = Jornal.find( @jornal.id )

    assert_equal objectUpdated[:jornal][:name], jornal_object.name
    assert_equal objectUpdated[:jornal][:contact], jornal_object.contact
    assert_equal objectUpdated[:jornal][:observation], jornal_object.observation
    assert_equal objectUpdated[:jornal][:state_id], jornal_object.state.id
  end
end
