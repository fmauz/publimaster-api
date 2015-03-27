require 'test_helper'

class CreatingEmployeeTest < ActionDispatch::IntegrationTest
  setup do
    @street_suffix = FactoryGirl.create(:street_suffix)
    @city = FactoryGirl.create( :city )
  end

  test "creating a new employee" do
    objectCreated = {
      employee: {
        name: Faker::Name.name,
        cpf: "12345678",
        position: "Position",
        enrollment: "Enroll",
        date_of_admission: 2.year.ago,
        date_of_resignation: Time.zone.now,
        salary: 100.3,
        transportation_voucher_code: "Cod123",
        price_bus_passes: 102.3,
        observation: "Lorem!!",
        user: {
          email: Faker::Internet.email,
          password: "q1w2e3r4",
          password_confirmation: "q1w2e3r4"
        },
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

          post "/employees", objectCreated, {}

          assert_equal 200, response.status
          assert_equal Mime::JSON, response.content_type

          employee_object = Employee.find( json( response.body )["employee"]["id"] )

          assert_equal objectCreated[:employee][:name], employee_object.name
          assert_equal objectCreated[:employee][:cpf], employee_object.cpf

          assert_equal objectCreated[:employee][:name], employee_object.name
          assert_equal objectCreated[:employee][:cpf], employee_object.cpf
          assert_equal objectCreated[:employee][:position], employee_object.position
          assert_equal objectCreated[:employee][:enrollment], employee_object.enrollment
          assert_equal objectCreated[:employee][:date_of_admission].to_date, employee_object.date_of_admission
          assert_equal objectCreated[:employee][:date_of_resignation].to_date, employee_object.date_of_resignation
          assert_equal objectCreated[:employee][:salary], employee_object.salary
          assert_equal objectCreated[:employee][:transportation_voucher_code], employee_object.transportation_voucher_code
          assert_equal objectCreated[:employee][:price_bus_passes], employee_object.price_bus_passes
          assert_equal objectCreated[:employee][:observation], employee_object.observation

          assert_equal objectCreated[:employee][:address][:street_suffix_id], employee_object.address.street_suffix.id
          assert_equal objectCreated[:employee][:address][:street_address], employee_object.address.street_address
          assert_equal objectCreated[:employee][:address][:secondary_address], employee_object.address.secondary_address
          assert_equal objectCreated[:employee][:address][:building_number], employee_object.address.building_number
          assert_equal objectCreated[:employee][:address][:neighborhood], employee_object.address.neighborhood
          assert_equal objectCreated[:employee][:address][:city_id], employee_object.address.city.id
          assert_equal objectCreated[:employee][:address][:state_id], employee_object.address.state.id
          assert_equal objectCreated[:employee][:address][:zipcode], employee_object.address.zipcode

          assert_equal objectCreated[:employee][:address][:contact_phones].size-1, employee_object.address.contact_phones.length

          assert_equal objectCreated[:employee][:address][:contact_phones][1][:area_code], employee_object.address.contact_phones[0].area_code
          assert_equal objectCreated[:employee][:address][:contact_phones][1][:phone_number], employee_object.address.contact_phones[0].phone_number
          assert_equal objectCreated[:employee][:address][:contact_phones][1][:extension], employee_object.address.contact_phones[0].extension
          assert_equal objectCreated[:employee][:address][:contact_phones][1][:is_fax], employee_object.address.contact_phones[0].is_fax

          assert_equal objectCreated[:employee][:address][:contact_emails].size-1, employee_object.address.contact_emails.length

          assert_equal objectCreated[:employee][:address][:contact_emails][1][:email], employee_object.address.contact_emails[0].email
          assert_equal objectCreated[:employee][:address][:contact_emails][1][:contact], employee_object.address.contact_emails[0].contact
        end

        test "creating a new employee with a invalid params" do
          invalidObject = { employee: { observation: Faker::Lorem.paragraph(2), address: { neighborhood: "Neighborhood" } } }
          post "/employees", invalidObject, {}

          assert_equal 422, response.status
          assert_equal Mime::JSON, response.content_type

          jsonObject = json( response.body )

          assert jsonObject["name"].include? "can't be blank"
          assert jsonObject["cpf"].include? "can't be blank"

          assert jsonObject["address.street_suffix"].include? "can't be blank"
          assert jsonObject["address.street_address"].include? "can't be blank"
          assert jsonObject["address.building_number"].include? "can't be blank"
          assert jsonObject["address.city"].include? "can't be blank"
          assert jsonObject["address.state"].include? "can't be blank"
          assert jsonObject["address.zipcode"].include? "can't be blank"
        end
end
