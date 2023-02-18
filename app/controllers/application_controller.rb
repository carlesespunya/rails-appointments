class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to request.referer || root_path, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :city])
  end

  private

  def require_patient
    if current_user.role == 'Doctor'
      redirect_to root_path, alert: "You must be a doctor to access this page."
    end
  end
end
