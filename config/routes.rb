Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/sign_in' => 'auth#sign_in'
  get '/sign_out' => 'auth#sign_out'
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :tags, only: [:index, :create, :update, :destroy]
  resources :user_tags, only: [:destroy]
end
