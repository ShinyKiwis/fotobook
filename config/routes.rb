Rails.application.routes.draw do
  match '*path', via: [:options], to: lambda {|_| [204, { 'Content-Type' => 'text/plain' }]}
  root "application#welcome"

  devise_for :users,path_names: {
    edit: ':id/edit'
  }, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # put 'users/basic_info', to: 'users/registrations#update_basic_info'


  resources :users do
    resources :photos, :albums
  end

  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#reset'

  resource :session, only: %i[new create destroy]

  scope :feeds, as: 'feeds', shallow_path: 'feeds' do
    resources :photos, :albums
  end

  scope :discover, as: 'discover', shallow_path: 'discover' do
    resources :photos, :albums
  end

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

end
