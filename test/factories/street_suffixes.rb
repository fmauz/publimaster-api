FactoryGirl.define do
  factory :street_suffix do
    name { Faker::Address.street_suffix }
  end

end
