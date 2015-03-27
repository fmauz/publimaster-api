class Retranca < ActiveRecord::Base
  belongs_to :jornal

  validates :name,
            presence: true
end
