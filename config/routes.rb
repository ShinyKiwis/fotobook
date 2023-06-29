Rails.application.routes.draw do
  root "application#index"
  resources :users
  resource :session, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
end
