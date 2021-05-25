Rails.application.routes.draw do
  get '/search', to: 'tmdb_api#search'
  get '/recommendations', to: 'tmdb_api#recommendations'
  
  resources :movies
  resources :users do 
    resources :reviews
  end
end
