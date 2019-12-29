class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken
  # protect_from_forgery with: :null_session #セキュリティ上問題あり
  protect_from_forgery
end
