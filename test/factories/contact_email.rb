FactoryGirl.define do
	factory :contact_email do
		address
		email { Faker::Internet.email }
		contact { Faker::Name.name }
	end
end