class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Category
    can :read, Venue
    can :read, Review
    can :read, Event, state: Event.states[:published]

    return unless user.persisted?

    can :read, Event, user_id: user.id
    can :create, Event
    can [:update, :publish, :cancel], Event, user_id: user.id
    can :create, Registration
    can :destroy, Registration, user_id: user.id
    can :create, Review

    if user.admin?
      can :manage, Category
      can :manage, Venue
      can :manage, User
      can :manage, Review
      can :manage, Event
      can :read, Registration
    end
  end
end
