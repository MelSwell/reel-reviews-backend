Rails.application.routes.draw do
  get '/search', to: 'search#submit'
  
  resources :movies
  resources :users do 
    resources :reviews
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
