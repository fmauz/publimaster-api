class Material < ActiveRecord::Base
  validates :name,
            presence: true
end
