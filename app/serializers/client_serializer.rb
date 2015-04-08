class ClientSerializer < ActiveModel::Serializer
  attributes :id,
      			 :name, 
      			 :cpf_cnpj, 
      			 :director, 
      			 :accountant, 
      			 :client_group, 
      			 :observation,
             :client_type_id,
             :segment_id,
             :employee_id,
             :phone

  has_one :client_type
  has_one :segment
  has_one :address
  has_one :employee

  has_many :responsibles

  def phone
    self.address.contact_phones.first
  end
end
