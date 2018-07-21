Rails.application.routes.draw do
  get "sign_in" => "users#sign_in"
  get "change_password" => "users#change_password"
  get "signed_out" => "users#signed_out"
  get "new_user" => "users#new_user"
  get "forgot_password" => "users#forgot_password"
  get "password_sent" => "users#password_sent"
  get "account_settings" => "users#account_settings"
  put "account_settings" => "users#set_account_info"
  root 'tasks#index'
  resources :tasks
  post "sign_in" => "users#login"
  post "tasks/new" => "tasks#create"
  post "new_user" => "users#register"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
