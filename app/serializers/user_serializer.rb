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
      medium:  self.object.avatar.url(:medium),
      thumb: self.object.avatar.url(:thumb)
    }
  end
end
