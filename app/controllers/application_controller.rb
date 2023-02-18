class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :city])
  end

  private

  def require_patient
    if current_user.role == "Doctor"
      redirect_to root_path, alert: "You must be a patient to access this page."
    end
  end

  def set_is_doctor
    @is_doctor = current_user.role == 'Doctor'
  end
end
