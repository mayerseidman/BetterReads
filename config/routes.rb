Omniauthpls::Application.routes.draw do
  resources :users
  # get "users/new"
  # get "users/create"
  # get "users/update"
  # get "users/edit"
  # get "users/destroy"
  # get "users/index"
  # get "users/show"
 
  get '/auth/:goodreads/callback', :to => 'sessions#create'
  root :to => "users#show"
  get 'signout', to: 'sessions#destroy', as: 'signout'

end
