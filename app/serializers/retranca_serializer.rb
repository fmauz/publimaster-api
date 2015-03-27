class RetrancaSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :source,
             :body,
             :lead,
             :width,
             :height,
             :column_count,
             :column_width
end
