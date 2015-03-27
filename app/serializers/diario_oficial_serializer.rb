class DiarioOficialSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :contact,
             :state_id,
             :observation,
             :schedule,
             :source,
             :body,
             :lead,
             :width,
             :height,
             :column_count,
             :cm_price,
             :cm_price_exemplar,
             :sedex_price,
             :website,
             :archive_type,
             :rules


  has_one :state
end
