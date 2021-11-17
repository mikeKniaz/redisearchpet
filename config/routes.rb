Rails.application.routes.draw do
  root to: 'stories#index'
  resources :stories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
