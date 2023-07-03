Rails.application.routes.draw do
  root "application#welcome"
  resources :users
  resource :session, only: [:new, :create, :destroy]

  scope :feeds, as: 'feeds', shallow_path: 'feeds' do
    resources :photos, :albums
  end

  scope :discover, as: 'discover', shallow_path: 'discover' do
    resources :photos, :albums
  end

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
end
