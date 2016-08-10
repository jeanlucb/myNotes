Rails.application.routes.draw do
  resources :documents
  resources :to_dos
  get 'tags/', to: 'dashboard#index'
  get 'tags/:tag', to: 'tag#index', as: :tag
  resources :notes
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
end
