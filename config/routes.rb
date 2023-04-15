Rails.application.routes.draw do
  #rails_admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # get 'users/show'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :blogs
  root 'blogs#index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
