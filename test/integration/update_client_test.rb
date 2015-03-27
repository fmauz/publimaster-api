require 'test_helper'

class UpdateClientTest < ActionDispatch::IntegrationTest
  setup do
    @client = FactoryGirl.create( :client )

    @client_type = FactoryGirl.create(:client_type)
    @street_suffix = FactoryGirl.create(:street_suffix)
    @city = FactoryGirl.create( :city )
    @segment = FactoryGirl.create( :segment )
    @employee = FactoryGirl.create( :employee )
  end

  test "show client informations" do
    objectUpdated = { 
      client: {
        name: Faker::Name.name,
        client_type_id: @client_type.id,
        cpf_cnpj: "12345678",
        responsible: Faker::Name.name,
        director: Faker::Name.name,
        accountant: Faker::Name.name,
        client_group: "Groupt Client",
        observation: Faker::Lorem.paragraph(2),
        segment_id: @segment.id,
        employee_id: @employee.id,
        address: {
          id: @client.address.id,
          street_suffix_id: @street_suffix.id,
          street_address: Faker::Address.street_address,
          secondary_address: Faker::Address.secondary_address,
          building_number: Faker::Address.building_number,
          neighborhood: "Neighborhood South",
          city_id: @city.id,
          state_id: @city.state.id,
          zipcode: Faker::Address.zip,
          contact_phones: [{
            id: @client.address.contact_phones[0].id,
            _destroy: true
          },{
            id: @client.address.contact_phones[1].id,
            area_code: Faker::PhoneNumber.area_code,
            phone_number: Faker::PhoneNumber.phone_number,
            extension: Faker::PhoneNumber.extension,
            is_fax: false
          },{
            area_code: Faker::PhoneNumber.area_code,
            phone_number: Faker::PhoneNumber.phone_number,
            extension: Faker::PhoneNumber.extension,
            is_fax: true
          }],
          contact_emails: [{
            id: @client.address.contact_emails[0].id,
            _destroy: true
          },{
            id: @client.address.contact_emails[1].id,
            email: Faker::Internet.email,
            contact: Faker::Name.name
          },{
            email: Faker::Internet.email,
            contact: Faker::Name.name
          }]

        }
      }
    }

    put "/clients/#{@client.id}", objectUpdated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    client_object = Client.find( @client.id )

    assert_equal objectUpdated[:client][:name], client_object.name
    assert_equal objectUpdated[:client][:cpf_cnpj], client_object.cpf_cnpj
    assert_equal objectUpdated[:client][:responsible], client_object.responsible
    assert_equal objectUpdated[:client][:director], client_object.director
    assert_equal objectUpdated[:client][:accountant], client_object.accountant
    assert_equal objectUpdated[:client][:client_group], client_object.client_group
    assert_equal objectUpdated[:client][:observation], client_object.observation

    assert_equal objectUpdated[:client][:client_type_id], client_object.client_type_id
    assert_equal objectUpdated[:client][:segment_id], client_object.segment_id
    assert_equal objectUpdated[:client][:employee_id], client_object.employee_id

    assert_equal objectUpdated[:client][:address][:street_suffix_id], client_object.address.street_suffix_id
    assert_equal objectUpdated[:client][:address][:street_address], client_object.address.street_address
    assert_equal objectUpdated[:client][:address][:secondary_address], client_object.address.secondary_address
    assert_equal objectUpdated[:client][:address][:building_number], client_object.address.building_number
    assert_equal objectUpdated[:client][:address][:neighborhood], client_object.address.neighborhood
    assert_equal objectUpdated[:client][:address][:city_id], client_object.address.city_id
    assert_equal objectUpdated[:client][:address][:state_id], client_object.address.state_id
    assert_equal objectUpdated[:client][:address][:zipcode], client_object.address.zipcode

    assert_equal objectUpdated[:client][:address][:contact_phones].size-1, client_object.address.contact_phones.length

    2.times{|a|
      assert_equal objectUpdated[:client][:address][:contact_phones][a+1][:area_code], client_object.address.contact_phones[a].area_code
      assert_equal objectUpdated[:client][:address][:contact_phones][a+1][:phone_number], client_object.address.contact_phones[a].phone_number
      assert_equal objectUpdated[:client][:address][:contact_phones][a+1][:extension], client_object.address.contact_phones[a].extension
      assert_equal objectUpdated[:client][:address][:contact_phones][a+1][:is_fax], client_object.address.contact_phones[a].is_fax
    }

    assert_equal objectUpdated[:client][:address][:contact_emails].size-1, client_object.address.contact_emails.length

    2.times{|a|
      assert_equal objectUpdated[:client][:address][:contact_emails][a+1][:email], client_object.address.contact_emails[a].email
      assert_equal objectUpdated[:client][:address][:contact_emails][a+1][:contact], client_object.address.contact_emails[a].contact
    }

  end
end
