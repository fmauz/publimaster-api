class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, 
         :validatable, :omniauthable, :authentication_keys => [:email]
  
  include DeviseTokenAuth::Concerns::User

  has_attached_file :avatar, 
                    :styles => { 
                      :medium => "300x300#", 
                      :thumb => "100x100#"
                    }, :default_url => "/images/:style/missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  belongs_to :role
  has_one :employee

  before_validation(on: :create) do
    self.uid = self.email
    self.provider = "email"
    self.skip_confirmation!
  end

  def as_json(attr)
    UserSerializer.new( self )
  end

  def upload=( base )
    self.avatar = base
  end

  def is_adm?
    self.role_id == 1
  end
end
