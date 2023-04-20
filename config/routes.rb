Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'tops#index'

  devise_for :users

  devise_scope :user do
    post 'users/guest_parent_sign_in', to: 'users/sessions#guest_parent_sign_in'
    post 'users/guest_child_sign_in', to: 'users/sessions#guest_child_sign_in'
    post 'users/guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
  end

  resources :users, only: [:show, :edit, :update]
  resources :favorites, only: [:create, :destroy]
  resources :blogs do
    resources :comments
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
