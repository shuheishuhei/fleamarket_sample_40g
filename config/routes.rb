Rails.application.routes.draw do
  root 'items#index'
  resources :items
  resources :item_images, only: :edit

end
