class User < ApplicationRecord
  ROLE_GUEST = 0
  ROLE_OP = 1
  ROLE_ADMIN = 9
  ROLES = { ROLE_GUEST  => :guest,
            ROLE_OP     => :op,
            ROLE_ADMIN  => :admin
          }.freeze

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :name, :password, :password_confirmation, :remember_me

  validates_presence_of :email
  validates_inclusion_of :role, :in => ROLES.keys

  def display_name
    name || email
  end

  def role?(role)
    ROLES[self.role] == role.to_sym
  end

end
