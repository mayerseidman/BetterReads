Omniauthpls::Application.routes.draw do

 
  resources :users
 
  # get 'https://betterreads.herokuapp.com/auth/goodreads/callback', :to => 'sessions#create'
  get '/auth/:goodreads/callback', :to => 'sessions#create'
  root :to => "users#show"
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'groups', to: 'groups#index', as: 'listgroups'
  get 'group/:id' , to: 'groups#show', as: 'group'

end