# == Route Map
#
#                                Prefix Verb     URI Pattern                                                                              Controller#Action
#                                  root GET      /                                                                                        home#index
#                          api_v1_users GET      /api/v1/users(.:format)                                                                  api/v1/users#index {:format=>/json/}
#                                       POST     /api/v1/users(.:format)                                                                  api/v1/users#create {:format=>/json/}
#                           api_v1_user GET      /api/v1/users/:id(.:format)                                                              api/v1/users#show {:format=>/json/}
#                                       PATCH    /api/v1/users/:id(.:format)                                                              api/v1/users#update {:format=>/json/}
#                                       PUT      /api/v1/users/:id(.:format)                                                              api/v1/users#update {:format=>/json/}
#                                       DELETE   /api/v1/users/:id(.:format)                                                              api/v1/users#destroy {:format=>/json/}
#                  new_api_user_session GET      /api/v1/auth/sign_in(.:format)                                                           devise_token_auth/sessions#new {:format=>/json/}
#                      api_user_session POST     /api/v1/auth/sign_in(.:format)                                                           devise_token_auth/sessions#create {:format=>/json/}
#              destroy_api_user_session DELETE   /api/v1/auth/sign_out(.:format)                                                          devise_token_auth/sessions#destroy {:format=>/json/}
#                 new_api_user_password GET      /api/v1/auth/password/new(.:format)                                                      devise_token_auth/passwords#new {:format=>/json/}
#                edit_api_user_password GET      /api/v1/auth/password/edit(.:format)                                                     devise_token_auth/passwords#edit {:format=>/json/}
#                     api_user_password PATCH    /api/v1/auth/password(.:format)                                                          devise_token_auth/passwords#update {:format=>/json/}
#                                       PUT      /api/v1/auth/password(.:format)                                                          devise_token_auth/passwords#update {:format=>/json/}
#                                       POST     /api/v1/auth/password(.:format)                                                          devise_token_auth/passwords#create {:format=>/json/}
#          cancel_api_user_registration GET      /api/v1/auth/cancel(.:format)                                                            api/v1/auth/registrations#cancel {:format=>/json/}
#             new_api_user_registration GET      /api/v1/auth/sign_up(.:format)                                                           api/v1/auth/registrations#new {:format=>/json/}
#            edit_api_user_registration GET      /api/v1/auth/edit(.:format)                                                              api/v1/auth/registrations#edit {:format=>/json/}
#                 api_user_registration PATCH    /api/v1/auth(.:format)                                                                   api/v1/auth/registrations#update {:format=>/json/}
#                                       PUT      /api/v1/auth(.:format)                                                                   api/v1/auth/registrations#update {:format=>/json/}
#                                       DELETE   /api/v1/auth(.:format)                                                                   api/v1/auth/registrations#destroy {:format=>/json/}
#                                       POST     /api/v1/auth(.:format)                                                                   api/v1/auth/registrations#create {:format=>/json/}
#            api_v1_auth_validate_token GET      /api/v1/auth/validate_token(.:format)                                                    devise_token_auth/token_validations#validate_token
#                   api_v1_auth_failure GET      /api/v1/auth/failure(.:format)                                                           devise_token_auth/omniauth_callbacks#omniauth_failure
#                                       GET      /api/v1/auth/:provider/callback(.:format)                                                devise_token_auth/omniauth_callbacks#omniauth_success
#                                       GET|POST /omniauth/:provider/callback(.:format)                                                   devise_token_auth/omniauth_callbacks#redirect_callbacks
#                      omniauth_failure GET|POST /omniauth/failure(.:format)                                                              devise_token_auth/omniauth_callbacks#omniauth_failure
#                                       GET      /api/v1/auth/:provider(.:format)                                                         redirect(301)
#         rails_mandrill_inbound_emails POST     /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#         rails_postmark_inbound_emails POST     /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST     /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST     /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#          rails_mailgun_inbound_emails POST     /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET      /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST     /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET      /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET      /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET      /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT      /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE   /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST     /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET      /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET      /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET      /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT      /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST     /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get 'favorites/index'
    end
  end
  root to: 'home#index'
  
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :users, only: [:show]
      get 'allusers', to: 'users#all_users'

      resources :habits, only: [:show, :create]
      get 'habits', to: 'habits#users_habits_show'
      get 'allhabits', to: 'habits#all_habits_show'
      post 'habitlike', to: 'habits#like'
      post 'habitunlike', to: 'habits#unlike'
    end
  end

  namespace :api, {format: 'json'} do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
    end
  end

end
