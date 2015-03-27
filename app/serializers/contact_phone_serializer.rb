class ContactPhoneSerializer < ActiveModel::Serializer
  attributes :id, :area_code, :phone_number, :extension, :is_fax
end