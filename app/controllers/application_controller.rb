class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_i18n_locale_from_params
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource
  
  def default_url_options
    { locale: I18n.locale }
  end
  protected
    def layout_by_resource
      if devise_controller?
        "devise"
      else
        "application"
      end
    end

    def after_sign_in_path_for(resource)
      users_path
    end
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :handphone, :avatar, :date_of_birth, :address, :year_of_entry, :year_graduated])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
				else
				flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end
end
