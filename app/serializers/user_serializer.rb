class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :name,
             :avatar,
             :role_id

  has_one :role

  def name
    self.object.employee.name unless self.object.employee.nil?
  end

  def avatar
    { 
      medium:  URI.join(ActionController::Base.asset_host, self.object.avatar.url(:medium) ).to_s,
      thumb: URI.join(ActionController::Base.asset_host, self.object.avatar.url(:thumb) ).to_s
    }
  end
end
