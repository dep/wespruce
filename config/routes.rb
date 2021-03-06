R12Team365::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'users/registrations', passwords: 'users/passwords' }

  get 'users/profile/:username', to: 'users/profile#show', as: :profile, username: %r([^/;,?]+)

  resources :projects do
    get :search, on: :collection
    member do
      post :comment
      delete :remove_comment
      post :claim
      post :verify
      post :unclaim
      post :complete
    end
  end

  get 'projects/zipcode/:zipcode', to: 'projects#index', zipcode: /\d{5}/, as: 'projects_by_zipcode'

  get 'leaderboard', to: 'leaderboard#index'
  get 'leaderboard/:zipcode', to: 'leaderboard#by_zipcode', zipcode: /\d{5}/, as: 'leaderboard_by_zipcode'

  get 'pages/:action', to: 'pages', action: /[a-z-]+/, as: :page
  root to: 'pages#root'
end
