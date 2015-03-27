class Publicacao < ActiveRecord::Base
  belongs_to :client
  belongs_to :diario_oficial
  belongs_to :jornal

  belongs_to :diario_oficial_material, class: Material
  belongs_to :jornal_material, class: Material

  validates :client,
            presence: true
end
