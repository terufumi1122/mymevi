Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
