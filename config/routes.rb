require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end

  resource :profile, only: [:show, :edit,  :update]


  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do

    resource :like, only: [:show, :create, :destroy]
    resources :comments, only: [:index, :create, :destroy]
  end

  resource :timeline, only: [:show]
  resource :timelinelike, only: [:show]

end
