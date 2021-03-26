Rails.application.routes.draw do
   resources :likes
   root to: 'posts#index'
   resources :posts do 
   	post :publish, on: :member
   end
    
   resources :users, only: [:new, :create]
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   get 'logout', to: 'sessions#delete'
   get 'welcome', to: 'sessions#welcome'
end