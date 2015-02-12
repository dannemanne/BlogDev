class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      # Users can manage their own Posts
      can :manage, Post, :user_id => user.id
    end

    # Admins can manage all
    if user.role? :admin
      can :manage, :all

    # Ops can manage Comments
    elsif user.role? :op
      can :manage, Tag

    end

    # Everybody can read posted Posts
    can :read, Post, status: PostStatus::POSTED
    can :read, Tag
    can :read, CheatSheet

  end
end
