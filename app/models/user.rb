class User < ActiveRecord::Base
  ROLES = { 0 => :guest,
            1 => :op,
            9 => :admin
          }.freeze

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me

  attr_protected :role

  def display_name
    self.name.blank? ? self.email : self.name
  end

  def role?(role)
    ROLES[self.role] == role.to_sym
  end
end
