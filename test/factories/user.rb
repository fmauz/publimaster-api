FactoryGirl.define do
	factory :user do
		email { Faker::Internet.email }
    uid { email }
    provider "email"
		password "q1w2e3r4"
		password_confirmation "q1w2e3r4"
		role

    before(:create) do |user|
      user.skip_confirmation!
    end
	end
end