FactoryGirl.define do
  factory :diario_oficial do
    name { Faker::Company.name }
    observation { Faker::Lorem.paragraph(2) }
    contact { Faker::Name.name }

    state
    
    schedule "00:00"
    source "Fonte"
    body "Corpo"
    lead "Aqui entra as entrelinhas"
    column 1
    width 10.2
    height 30.4
    column_count 4
    column_width 40.2
  end
end