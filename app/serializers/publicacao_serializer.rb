class PublicacaoSerializer < ActiveModel::Serializer
  attributes :id,
             :price,
             :publication_date_diario_oficial,
             :publication_date_jornal,
             :height_jornal,
             :coluna_jornal,
             :total_jornal,
             :client_id,
             :diario_oficial_id,
             :jornal_id,
             :jornal_material_id,
             :diario_oficial_material_id

  has_one :diario_oficial
  has_one :jornal
  has_one :client

  has_one :diario_oficial_material
  has_one :jornal_material
end
