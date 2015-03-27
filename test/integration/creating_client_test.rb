require 'test_helper'

class CreatingClientTest < ActionDispatch::IntegrationTest
  setup do
    @client_type = FactoryGirl.create(:client_type)
    @street_suffix = FactoryGirl.create(:street_suffix)
    @city = FactoryGirl.create( :city )
    @segment = FactoryGirl.create( :segment )
    @employee = FactoryGirl.create( :employee )
  end

  test "creating a new client" do
    objectCreated = { 
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
          street_suffix_id: @street_suffix.id,
          street_address: Faker::Address.street_address,
          secondary_address: Faker::Address.secondary_address,
          building_number: Faker::Address.building_number,
          neighborhood: "Neighborhood South",
          city_id: @city.id,
          state_id: @city.state.id,
          zipcode: Faker::Address.zip,
          contact_phones: [
            {
              area_code: Faker::PhoneNumber.area_code,
              phone_number: Faker::PhoneNumber.phone_number,
              _destroy: true
            },{
              area_code: Faker::PhoneNumber.area_code,
              phone_number: Faker::PhoneNumber.phone_number,
              extension: Faker::PhoneNumber.extension,
              is_fax: false
            }
          ],
          contact_emails: [{
              email: Faker::Internet.email,
              contact: Faker::Name.name,
              _destroy: true
            },{
              email: Faker::Internet.email,
              contact: Faker::Name.name
            }]
          }
        }
      }

      post "/clients", objectCreated, {}

      assert_equal 200, response.status
      assert_equal Mime::JSON, response.content_type

      client_object = Client.find( json( response.body )["client"]["id"] )

      assert_equal objectCreated[:client][:name], client_object.name
      assert_equal objectCreated[:client][:cpf_cnpj], client_object.cpf_cnpj
      assert_equal objectCreated[:client][:responsible], client_object.responsible
      assert_equal objectCreated[:client][:director], client_object.director
      assert_equal objectCreated[:client][:accountant], client_object.accountant
      assert_equal objectCreated[:client][:client_group], client_object.client_group
      assert_equal objectCreated[:client][:observation], client_object.observation

      assert_equal objectCreated[:client][:client_type_id], client_object.client_type.id
      assert_equal objectCreated[:client][:segment_id], client_object.segment.id
      assert_equal objectCreated[:client][:employee_id], client_object.employee.id

      assert_equal objectCreated[:client][:address][:street_suffix_id], client_object.address.street_suffix.id
      assert_equal objectCreated[:client][:address][:street_address], client_object.address.street_address
      assert_equal objectCreated[:client][:address][:secondary_address], client_object.address.secondary_address
      assert_equal objectCreated[:client][:address][:building_number], client_object.address.building_number
      assert_equal objectCreated[:client][:address][:neighborhood], client_object.address.neighborhood
      assert_equal objectCreated[:client][:address][:city_id], client_object.address.city.id
      assert_equal objectCreated[:client][:address][:state_id], client_object.address.state.id
      assert_equal objectCreated[:client][:address][:zipcode], client_object.address.zipcode

      assert_equal objectCreated[:client][:address][:contact_phones].size-1, client_object.address.contact_phones.length

      assert_equal objectCreated[:client][:address][:contact_phones][1][:area_code], client_object.address.contact_phones[0].area_code
      assert_equal objectCreated[:client][:address][:contact_phones][1][:phone_number], client_object.address.contact_phones[0].phone_number
      assert_equal objectCreated[:client][:address][:contact_phones][1][:extension], client_object.address.contact_phones[0].extension
      assert_equal objectCreated[:client][:address][:contact_phones][1][:is_fax], client_object.address.contact_phones[0].is_fax

      assert_equal objectCreated[:client][:address][:contact_emails].size-1, client_object.address.contact_emails.length

      assert_equal objectCreated[:client][:address][:contact_emails][1][:email], client_object.address.contact_emails[0].email
      assert_equal objectCreated[:client][:address][:contact_emails][1][:contact], client_object.address.contact_emails[0].contact
    end

    test "creating a new client with a invalid params" do
      invalidObject = { client: { observation: Faker::Lorem.paragraph(2), address: { neighborhood: "Neighborhood" } } }
      post "/clients", invalidObject, {}

      assert_equal 422, response.status
      assert_equal Mime::JSON, response.content_type

      jsonObject = json( response.body )

      assert jsonObject["name"].include? "can't be blank"
      assert jsonObject["cpf_cnpj"].include? "can't be blank"
      assert jsonObject["employee"].include? "can't be blank"
      assert jsonObject["segment"].include? "can't be blank"
      assert jsonObject["client_type"].include? "can't be blank"

      assert jsonObject["address.street_suffix"].include? "can't be blank"
      assert jsonObject["address.street_address"].include? "can't be blank"
      assert jsonObject["address.building_number"].include? "can't be blank"
      assert jsonObject["address.city"].include? "can't be blank"
      assert jsonObject["address.state"].include? "can't be blank"
      assert jsonObject["address.zipcode"].include? "can't be blank"

      # Não pode ter CPF ou CNPJ duplicados

    end
  end
