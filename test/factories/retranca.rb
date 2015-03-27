FactoryGirl.define do
  factory :retranca do
    name { Faker::Company.name }

    source "Fonte"
    body "Corpo"
    lead "Entrelinhas aqui"
    
    column 1.5
    width 1.5
    height 1.5
    column_count 1
    column_width 1
  end

end
