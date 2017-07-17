class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new

    if user.is_admin?
      can :manage, [Post, Comment]
      can :destroy, User
    else
      can :create, [Post, Comment]
      can [:update, :destroy], [Post, Comment] do |resource|
        resource.user == user
      end
    end
  end
end
