class ResponsibleSerializer < ActiveModel::Serializer
  attributes :id, :name, :sector, :birthday, :cellphone, :phone
end
