class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  #   before_action :skip_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  #   def skip_session
  #     request.session_options[:skip] = true
  #   end

  def configure_permitted_parameters
    #     # devise_parameter_sanitizer.permit(許可したいアクション, keys: [許可したいパラメータ])
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:age, :gender, :format])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email birthday gender format avatar])
  end
end
