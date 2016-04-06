class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all

    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :jury
      can :set_rating, Work
      cannot :create, Work
    end

    if user.has_role? :participant
      can :create, Work
      can :update, Work, user_id: user.id
      can :destroy, Work, user_id: user.id
    end

  end
end
