class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def welcome
    redirect_to feeds_photos_url
  end
  
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource)
    puts "HERE"
    root_path
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:signup, keys: [:first_name, :last_name])
  end
end
