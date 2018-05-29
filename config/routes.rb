Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :graffiti_removals, only: :index

  root 'graffiti_removals#index'
end
