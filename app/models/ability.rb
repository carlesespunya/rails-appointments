class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :create], Appointment
  end
end
