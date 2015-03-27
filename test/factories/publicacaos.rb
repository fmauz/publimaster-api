FactoryGirl.define do
  factory :publicacao do
    client
    diario_oficial
    jornal
    price 1.5
    publication_date_diario_oficial "2015-01-13"
    publication_date_jornal "2015-01-13"
    height_jornal 1.5
    coluna_jornal 1.5
    total_jornal 1.5
    association :jornal_material, factory: :material
    association :diario_oficial_material, factory: :material
  end
end
