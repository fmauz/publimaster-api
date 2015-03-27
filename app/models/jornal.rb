class Jornal < ActiveRecord::Base
  belongs_to :state

  has_many :contact_emails, dependent: :destroy
  has_many :contact_phones, dependent: :destroy

  accepts_nested_attributes_for :contact_emails, allow_destroy: true
  accepts_nested_attributes_for :contact_phones, allow_destroy: true

  validates :name,
            :state,
            presence: true
end
