FactoryGirl.define do
	factory :contact_phone do
		address
		area_code { 21 }
		phone_number { Faker::Number.number(9) }
		extension { Faker::PhoneNumber.extension }
		is_fax true
	end
end