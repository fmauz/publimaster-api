class AddressSerializer < ActiveModel::Serializer
  attributes :id,
  			 :street_suffix_id,
  			 :street_address,
  			 :secondary_address,
  			 :building_number,
  			 :neighborhood,
  			 :zipcode,
         :city_id,
         :state_id

  has_one :street_suffix
  has_one :city
  has_one :state

  has_many :contact_phones
  has_many :contact_emails
end
