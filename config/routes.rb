Rails.application.routes.draw do

  

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root 'static_pages#home'

  get '/help', to: 'static_pages#help', as: 'help'
  get  '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  #sign_up
  get '/sign_up', to: 'users#new', as: 'sign_up'
  post '/sign_up',  to: 'users#create'
  #sessions
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]

 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
end
