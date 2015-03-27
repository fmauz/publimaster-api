FactoryGirl.define do
  factory :jornal do
    name { Faker::Company.name }
    observation { Faker::Lorem.paragraph(2) }
    contact { Faker::Name.name }
    state
  end
end