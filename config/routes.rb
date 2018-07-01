Rails.application.routes.draw do
  root "users#index"
  get "/edit" => "users#edit"
  get "/new" => "users#new"
  get "/show" => "users#show"

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
