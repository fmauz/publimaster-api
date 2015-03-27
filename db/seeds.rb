# FactoryGirl.create_list( :material, 5 )
# FactoryGirl.create_list( :segment, 5 )

ClientType.create!(name: "Pessoa Física")
ClientType.create!(name: "Pessoa Jurídica")

file_path = "#{Rails.root}/db/seed_data/"

File.open(file_path + 'estados.txt').each_with_index do |linha, index|
  pais, sigla, nome, ibge = linha.chomp.split("|")
  estado = State.create!( :state_abbr => sigla, :name => nome )
  puts "Importando Estado #{index} - #{nome}"
end

state = nil
File.open(file_path + 'cidades.txt').each_with_index do |linha, index|
  sigla, nome = linha.chomp.split(",")
  sigla.gsub!(/"/, '')
  nome.gsub!(/"/, '')
  state = State.find_by_state_abbr( sigla ) if state.nil? || state.state_abbr.strip.upcase != sigla.strip.upcase
  estado = City.create!( :state => state, :name => nome )
  puts "Importando Cidade #{index} - #{state.name} -> #{nome}"
end

street_suffix = StreetSuffix.create! name: "Rua"
StreetSuffix.create! name: "Avenida"

Role.create! name: "Administração"
Role.create! name: "Atendimento"
Role.create! name: "Diagramação"
Role.create! name: "Revisão"
Role.create! name: "Mídia"
roleDev = Role.create! name: "Desenvolvimento"

user = User.new( email: "fabio@inventae.com.br",
                 password: "q1w2e3r4",
                 password_confirmation: "q1w2e3r4",
                 provider: "email",
                 role: roleDev )
user.skip_confirmation!

address = Address.new(street_address: "Rua Benfica",
                      secondary_address: "Casa 1",
                      building_number: "295",
                      neighborhood: "Vila Leopoldina",
                      city: City.find_by_name("Duque de Caxias"),
                      state: State.find_by_name("Rio de Janeiro"),
                      street_suffix: street_suffix,
                      zipcode: "25060290")

Employee.create! name: "Fabio Martins",
                 cpf: "05878714744",
                 address: address,
                 position: "Programador",
                 user: user
