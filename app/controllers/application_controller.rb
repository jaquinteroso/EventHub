class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name])
  end

  private

  def user_not_authorized
    redirect_back fallback_location: root_path, alert: "You are not authorized to perform that action."
  end
end
