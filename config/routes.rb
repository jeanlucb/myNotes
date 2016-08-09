Rails.application.routes.draw do
  resources :to_dos
  get 'tags/:tag', to: 'notes#index', as: :tag
  resources :notes
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
end
