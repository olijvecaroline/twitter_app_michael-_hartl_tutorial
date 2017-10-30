Rails.application.routes.draw do

  

  root 'static_pages#home'

  get '/help', to: 'static_pages#help', as: 'help'
  get  '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/sign_up', to: 'users#new', as: 'sign_up'
  post '/sign_up',  to: 'users#create'

  resources :users
 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
end
