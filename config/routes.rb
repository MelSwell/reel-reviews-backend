Rails.application.routes.draw do
  get '/search', to: 'tmdb_api#search'
  get '/recommendations', to: 'tmdb_api#recommendations'
  post '/login', to: 'sessions#login'
  
  resources :movies
  resources :users do 
    resources :reviews
  end
end
