Rails.application.routes.draw do
  match '*path', via: [:options], to: lambda {|_| [204, { 'Content-Type' => 'text/plain' }]}
  root "application#welcome"

  devise_for :users,path_names: {
    edit: ':id/edit'
  }, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }


  resource :admin do
    get 'photos', to: 'admins#index'
    get 'albums', to: 'admins#index'
    get 'users', to: 'admins#index'
    post 'users', to: 'admins#delete_user'
  end

  # put 'users/basic_info', to: 'users/registrations#update_basic_info'


  resources :users do
    resources :photos, :albums
    get '/followings', to: 'users#following_index'
    get '/followers', to: 'users#follower_index'
  end

  # Forgot password feature
  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#reset'

  # Like feature
  post 'photo/like/:id', to: 'photos#like', as: 'like_photo'
  post 'album/like/:id', to: 'albums#like', as: 'like_album'

  resource :session, only: %i[new create destroy]
  resources :follows, only: %i[create destroy]

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
