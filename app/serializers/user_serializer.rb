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
    if Rails.env == "development"
      { 
        medium:  URI.join(ActionController::Base.asset_host, self.object.avatar.url(:medium) ).to_s,
        thumb: URI.join(ActionController::Base.asset_host, self.object.avatar.url(:thumb) ).to_s
      }
    else
      { 
        medium:  self.object.avatar.url(:medium),
        thumb: self.object.avatar.url(:thumb)
      }
    end
  end
end
