class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameteres, if: :devise_controller?

  private
  def configure_permitted_parameteres
    devise_parameter_sanitizer.permit(:sign_up, keys: [:encrypted_password, :name, :profile, :occupation, :position])
  end
end
