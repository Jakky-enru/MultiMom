Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # get 'users/show'
  devise_for :users
  root 'tops#index'
  resources :users, only: [:show, :edit, :update]
  resources :favorites, only: [:create, :destroy]
  resources :blogs do
    resources :comments
  end
  # root 'blogs#index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
