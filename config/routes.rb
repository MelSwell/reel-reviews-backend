Rails.application.routes.draw do
  get '/search', to: 'tmdb_api#search'
  get '/recommendations', to: 'tmdb_api#recommendations'
  post '/login', to: 'sessions#login'
  get '/auto-login', to: 'sessions#auto_login'
  
  resources :movies
  resources :users do 
    resources :reviews
  end
end
