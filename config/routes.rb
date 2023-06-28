Rails.application.routes.draw do
  root "application#index"
  resource :users

  get 'signup', to: 'users#new', as: 'signup'
end
