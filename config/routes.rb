Rails.application.routes.draw do
  get 'wowza/index'

  resources :streams

  root 'wowza#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
