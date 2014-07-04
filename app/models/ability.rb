class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Users can manage their own Posts and Comments
    if user.persisted?
      can :manage, Post, :user_id => user.id
      can :manage, Comment, :user_id => user.id
      cannot :span, Comment, :user_id => user.id
    end

    # Admins can manage all
    if user.role? :admin
      can :manage, :all

    # Ops can manage Comments
    elsif user.role? :op
      can :manage, Comment
      can :manage, Tag

    end

    # Everybody can read and comment on posted Posts
    can :read, Post, status: PostStatus::POSTED
    can :comment, Post, status: PostStatus::POSTED, allow_comments: true
    can :read, Tag
    can :read, CheatSheet

    # Tempoarary preventing comments
    cannot :create, Comment, allow_comments: false
    cannot :comment, Post,  allow_comments: false

  end
end
