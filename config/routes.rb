Rails.application.routes.draw do
  get 'mypage' => 'users#me'
  post 'login' => 'sessions#create'
  get 'login' => 'users#login'
  delete 'logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/boards' => 'boards#index'
  # get '/boards/new' => 'boards#new'
  # post '/boards' => 'boards#create'
  # get '/boards/:id' => 'boards#show'
  root 'home#index'
  resources :users, only: %i[new create]
  resources :boards
  resources :comments, only: %i[create destroy]
end
