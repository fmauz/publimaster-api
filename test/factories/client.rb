FactoryGirl.define do
	factory :client do
		name { Faker::Name.name }
		cpf_cnpj { Faker::CPF.pretty }
		client_type
		responsible { Faker::Name.name }
		director { Faker::Name.name }
		accountant { Faker::Name.name }
		client_group "Grupo do cliente"
		observation { Faker::Lorem.paragraph(2) }
		address
		segment
		employee
	end
end