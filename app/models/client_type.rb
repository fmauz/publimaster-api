class ClientType < ActiveRecord::Base
  default_scope ->{ order("name") }

  validates :name,
            presence: true
end
