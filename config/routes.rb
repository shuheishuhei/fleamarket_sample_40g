Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to:'users/registrations#create_profile'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'users/:id', to: 'users#show'
  end
  root 'items#index'
  resources :users 
  resources :items, only: [:index, :new, :show] do
    member do
      get  "buy"
      post "pay"
      get 'purchase_comfirmation'
    end
    
    
    collection do
      
    end
  end
  resources :cards, only: [:new, :create, :show, :destroy] do
    
    
  end

  
end