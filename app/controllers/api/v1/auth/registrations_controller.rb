# module Api
#   module V1
#     module Auth
      class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

        private
        def sign_up_params
          params.permit(:name, :email, :birth_year, :birth_month, :birth_day, :gender, :password, :password_confirmation)
        end

        def account_update_params
          params.permit(:name, :email, :birth_year, :birth_month, :birth_day, :gender, :password, :password_confirmation)
        end

  #     end
  #   end
  # end
end