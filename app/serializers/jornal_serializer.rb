class JornalSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :contact,
             :state_id,
             :send_schedule,
             :send_type,
             :commissioning,
             :observation


  has_one :state
  has_many :contact_phones
  has_many :contact_emails
end
