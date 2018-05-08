Rails.application.routes.draw do
  root 'projects#index'
  
  resources :tags
  resources :tickets do
    resources :comments, except: [:show]
  end

  resources :projects
  resources :users, only: [:show, :create, :edit, :update]

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
