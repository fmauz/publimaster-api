class Employee < ActiveRecord::Base
  belongs_to :address, dependent: :destroy
  belongs_to :user, dependent: :destroy

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :user

  validates :name,
            :cpf,
            :user,
            :address,
            presence: true
end
