class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Admins can manage all
    if user.role? :admin
      can :manage, :all

    # Ops can manage Comments
    elsif user.role? :op
      can :manage, Comment
      can :manage, Tag

    end

    # Users can manage their own Posts
    if user.persisted?
      can :manage, Post, :user_id => user.id
    end

    # Everybody can read and comment on posted Posts
    can :read, Post, :status => Post::STATUS_POSTED
    can :comment, Post, :status => Post::STATUS_POSTED
    can :read, Tag

    # Tempoarary preventing comments
    cannot :create, Comment
    cannot :comment, Post

  end
end
