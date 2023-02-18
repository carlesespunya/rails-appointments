class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :create], Appointment
    can [:update, :destroy], Appointment, user: user
  end
end
