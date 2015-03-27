FactoryGirl.define do
	factory :address do
		street_suffix
		street_address Faker::Address.street_address
		secondary_address Faker::Address.secondary_address
		building_number Faker::Address.building_number
		neighborhood "Neighborhood Example"
		city
		state { city.state }
		zipcode Faker::Address.zip
		
		after( :create ) do |address|
			FactoryGirl.create_list( :contact_phone, 2, address: address )
			FactoryGirl.create_list( :contact_email, 2, address: address )
		end
	end
end