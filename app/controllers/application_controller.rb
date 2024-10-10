class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    additional_keys = [
      :first_name,
      :last_name,
      :image_url,
      :address,
      :phone_number,
    ]
    devise_parameter_sanitizer.permit(:sign_up, keys: additional_keys)
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: additional_keys)
  end
end
