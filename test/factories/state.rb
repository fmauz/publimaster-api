FactoryGirl.define do
	factory :state do
		name { Faker::Address.state }
		state_abbr { Faker::Address.state_abbr }
	end
end