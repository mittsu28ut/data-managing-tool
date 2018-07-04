Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  post "tasks/new" => "tasks#create"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
