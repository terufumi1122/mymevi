class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  #   before_action :skip_session
  #   before_action :configure_permitted_parameters

  # protected

  #   def skip_session
  #     request.session_options[:skip] = true
  #   end

  #   def configure_permitted_parameters
  #     # devise_parameter_sanitizer.permit(許可したいアクション, keys: [許可したいパラメータ])
  #     devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
  #     devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email, :password, :format])
  #   end

end
