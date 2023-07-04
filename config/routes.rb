Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  get 'account', to: 'users#account', as: 'account'
  get 'profile', to: 'users#show', as: 'profile'
  get 'profile/edit', to: 'users#edit', as: 'edit_profile' 
  resources :users
  resources :rooms do
    collection do
      get 'search'
      get 'search_by_area'
      get 'own'
    end
  end
  resources :reservations do
    collection do
      post :confirm
    end
  end
end
